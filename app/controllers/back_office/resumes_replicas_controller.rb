# frozen_string_literal: true

module BackOffice
  class ResumesReplicasController < BackOfficeController
    before_action :set_resume_replica, only: %i[show]

    def index
      @resumes_replicas = current_user.resumes_replicas.all
      @resume = current_user.resume
    end

    def show; end

    def new
      @resumes_replica = current_user.resume.dup
      @resumes_replica = @resumes_replica.becomes!(Resumes::Replica)
      @resumes_replica.recruter_image_url = ''

      return unless current_user.resumes_replicas.count.zero?

      @resumes_replica.recruter_full_name = 'Roland Lopez'
      @resumes_replica.recruter_email = 'rolandlopez.developer@gmail.com'
      @resumes_replica.recruter_image_url = 'https://media.licdn.com/dms/image/D5603AQEO2SDKT3atoA/profile-displayphoto-shrink_200_200/0/1704357362175?e=1711584000&v=beta&t=kT9woXKxeFVtt2qpqjezdN9QRNZtazs7J6RlPmFtSL0'
      @resumes_replica.job_description = "As the Senior Tech Lead at Loupe, Inc., you will play a crucial role in the development and maintenance of Loupe's suite of visual art streaming solutions, including our cloud-based SaaS solution, TV applications and DAM. Reporting directly to the Leadership team, you will be responsible for leading a team of talented engineers while directly contributing in all phases of the development lifecycle, from requirement gathering and design, to solution deployment and support. \n\nThis is a full-time remote position Loupe is made up of a small distributed team across the US (strong preference for candidates residing in Georgia, California, New York, New Jersey, or Florida).\n\nRESPONSIBILITIES\nDefining and building new architectures around product needs\nTroubleshooting and debuging complex technical issues, providing timely and effective resolutions.\nWriting clean, well-structured, scalable, and efficient code\nCoaching and mentoring team members through pair programming, code reviews, and process documentation\nWorking closely with the Product Team and Leadership to gather requirements and translate them into technical specifications and roadmaps that achieve company objectives and long term visions.\nDeveloping and maintaining coding standards to ensure high quality of code readability and reliability\nQUALIFICATIONS\nProven work experience in a similar role\nAbility to lead and coach engineers and help them grow\nAbility to architect complete fullstack features and solutions\nStrong expertise building on a Ruby on Rails tech stack\nExcellent work ethic and meticulous attention to detail, ability to work independently and multitask while staying organized  in a fast-paced and dynamic environment.\nStrong emotional intelligence and communication skills, working proactively and collaboratively with a distributed team\nAppreciation of Lifestyle/Culture/Music/Art/Tech \nNice to have: \nExperience building media platforms\nPrior experience at a media company\nExperience building tvOS, mobile, or other connected devices applications \nBasic understanding of content management systems or digital asset management systems"
    end

    def edit; end

    def create
      @resume = current_user.resume
      @resumes_replica = @resume.dup
      @resume.experiences.map { |experience| @resumes_replica.experiences << experience.dup }
      @resumes_replica.becomes!(Resumes::Replica)
      @resumes_replica.update(resume_params)

      respond_to do |format|
        if @resumes_replica.valid?
          format.html { redirect_to resumes_replicas_path, notice: 'Resume was successfully created.' }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @resume.update(resume_params)
          format.html { redirect_to resumes_replicas_path, notice: 'Resume was successfully updated.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_resume_replica
      @resume_replica = current_user.resumes_replicas.find(params[:id])
    end

    def resume_params
      params.require(:resumes_replica).permit(:title, :about, :recruter_email, :recruter_full_name,
                                              :recruter_image_url, :job_description)
    end
  end
end
