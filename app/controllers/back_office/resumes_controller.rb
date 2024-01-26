class BackOffice::ResumesController < BackOfficeController
  before_action :set_resume, only: %i[ edit update ]

  def edit
    if @is_onboarding_resume
      flash.now[:notice] = "We initalized a fresh resume for you. Click 'Back to resume'"
    end
  end

  def update
    respond_to do |format|
      if @resume.update(resume_params)
        format.html { redirect_to resume_url, notice: "Resume was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def add_skill
  end

  private
    def set_resume
      create_resume if current_user.resume.nil?

      @resume = current_user.resume
    end

    def create_resume
      @is_onboarding_resume = true
      current_user.create_resume(
        about: "Self-taught developer who fell in love with the Ruby on Rails framework 8 years ago.\n\nSince then, I've been exclusively working with Rails in startup and corporate teams of all sizes,\nwhile also launching SaaS projects to the market.\n\nI'm focusing on helping developers that need:\n        \n- Building momentum in your socials for your tech career and side-projects.\n- Consistency in marketing and content creation for side-projects.\n- Personal coaching about tech marketing and coding.\n- Defining your online tech persona for your platforms.\n\nIf this resonates with you, I would love to know more about your project. \n\nPlease feel free to book a meeting at your convenience. \n\n Find me here: https://linktr.ee/roland_lopez",
        experiences_attributes: [
          {
            title: "Youtube Channel: Rad Roland",
            description: "Tech channel created by a biker: Code to chase dreams.\nStrive to show that you can have a successful tech career and still follow your passion with intensity.",
            skills: "Ruby On Rails, Motorsports, Marketing, Content Creation, Scripting, SEO, Film Making, Growth Hacking",
            started_at: Time.current,
            ended_at: Time.current - 5.years
          },
          {
            title: "Freelance Face - Founder",
            description: "Bootstrapped SaaS project that aims to be the face of the freelance developer who needs to reach out to recruiters.\nFreelance Face provides a tailored resume using GenAI with video and calendar links for each job description while tracking views of your resume and sending you an email when the resume is viewed by a recruiter.",
            skills: "Ruby On Rails, Hotwire, Tailwind, Postgresql, Hatchbox.io, OpenAI",
            started_at: Time.current - 6.month,
            ended_at: Time.current - 12.month
          },
          {
            title: "Founder/Coach @ Nomad Joker",
            description: "Online Mentoring Course limited to 30 people to help developers reach their childhood dreams using coding and find themselves in marketing. Find more info here: https://linktr.ee/roland_lopez",
            skills: "Ruby On Rails, Hotwire, Personal Coaching",
            started_at: Time.current - 12.month,
            ended_at: Time.current - 18.month
          },
          {
            title: "Email Summarizer - Founder",
            description: "Bootstrapped SaaS project: A Google extension that writes emails for you.\nThis project was launched on AppSumo and had 150 users and summarized more than 27000 emails!",
            skills: "Ruby On Rails, Hotwire, Google Extension, Stripe, Coaching, Svelte",
            started_at: Time.current - 18.month,
            ended_at: Time.current - 24.month
           }
        ],
        meeting_link_settings: "https://calendly.com/rolandlopez/tech-nomad-screening",
        video_link_settings: "https://www.loom.com/share/0879103cd6cc4a26b1ef873ff053797a"
      )
    end

    def resume_params
      params.require(:resume).permit(:about, :meeting_link_settings, :video_link_settings, experiences_attributes: [:id, :description, :ended_at, :started_at, :title, :skills])
    end
end
