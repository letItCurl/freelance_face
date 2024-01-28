class ResumesReplicas::GenerateJob
  include Sidekiq::Job

  def perform(resume_id)
    @resumes_replica = Resumes::Replica.find(resume_id)

    conn = Faraday.new(url: 'https://api.openai.com/') do |builder|
      builder.request :authorization, 'Bearer', -> { Rails.application.credentials.dig(:open_ai, :secret_key) }
      builder.request :json
      builder.response :json
    end

    prompt_template = <<-HEO
      You are a helpful assistant and your job is to rewrite a basic resume formated in a stringified JSON into a more compelling version for a given job description.
      You can only answer with the following interface, comments represent additional information about how to render the string:

      ```Typescript
      {
        about: STRING
        experiences: Array<ExperienceType>
      }

      type ExperienceType = {
        id: string; // Do not forget or mix this id.
        title: string;
        description: Array<string>; // Only find the 3 most relatable points from the original resume for the resume rewrite. Each points should be 16 words maximum.
        skills: Array<string>; // Only technologies and languages, like: Ruby On Rails, React, Python, C# etc...
      }
      ```

      Here are the instructions on how you should rewrite the resume:
      - Treat the lecturer as a tech recruiter. Don't delve too deeply into the explanation.
      - The about section should anticipate the company's problems and teams need, but not deviate too much from the original text. The new text should be 80 words long maximum. Don't spend too many words describing the journey of how you learned to code or personal information.
      - Never repeat the technologies anywhere other than in the skill JSON key.
      - Reformat the title of each experience to be more in line with market standards.
      - For each experience, find the 3 most impactful feats from the original resume that are related to the job board. The writing should be a mix of challenge and numbers.

      Here are the instructions concerning the tone used:
      - Be casual unless otherwise specified
      - Don't apologise
      - Be terse
      - Be accurate and thorough
      - Value good arguments over authorities, the source is irrelevant
      - Consider new technologies and contrarian ideas, not just only what's mentioned in the job description, try to anticipate the need of the company.
      - No moral lectures
      - If your content policy is an issue, provide the closest acceptable response and explain the content policy issue afterward
      - No need to mention your knowledge cutoff
      - No need to disclose you're an AI

      Here is the resume:
      RESUME_INPUT

      Here is the job description:
      JOB_DESCRIPTION_INPUT

      Rewrite a new version of the resume in function of instructions given above.
    HEO

    resume_json = {
      about: @resumes_replica.about,
      experiences: @resumes_replica.experiences.map{|xp| {id: xp.id, title: xp.title, description: xp.description, skills: xp.skills}}
    }.to_json

    prompt_template = prompt_template.gsub(/RESUME_INPUT/, resume_json)
    prompt = prompt_template.gsub(/JOB_DESCRIPTION_INPUT/, @resumes_replica.job_description)

    data = {
      model: "gpt-4-0125-preview",
      response_format: { "type": "json_object" },
      messages: [
        {
          role: "system",
          content: prompt
        }
      ]
    }

    res = conn.post("v1/chat/completions", data)
    puts res.body
    enhanced_resume = JSON.parse(res.body.dig("choices")[0].dig("message", "content"))
    puts "---"
    puts enhanced_resume

    @resumes_replica.experiences.each do |xp|
      puts "xxxxxxxxxxxx"
      enhanced_xp = enhanced_resume["experiences"].find{|el| xp.id == el["id"]}
      xp.title = enhanced_xp["title"]
      xp.description = enhanced_xp["description"].map{|el| "- #{el}"}.join("\n\n")
      xp.skills = enhanced_xp["skills"].join(", ")
      puts xp.attributes
      xp.save
      puts "xxxxxxxxxxxx"
    end
    @resumes_replica.update(about: enhanced_resume["about"])
    @resumes_replica.done!
  end
end
