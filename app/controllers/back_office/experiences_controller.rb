class BackOffice::ExperiencesController < BackOfficeController
  before_action :set_resume, only: %i[ create  ]

  def create
    @experience = @resume.experiences.create(title: "New experience...")

    redirect_to (@resume.type == Resume.to_s) ? edit_resume_path : edit_resumes_replica_path(@resume)
  end

  def destroy
    @experience = current_user.experiences.find(params[:id])
    @experience.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@experience)
      end
    end
  end

  private
    def set_resume
      @resume = current_user.resumes.find(params[:id])
    end
end
