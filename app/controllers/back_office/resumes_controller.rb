class BackOffice::ResumesController < BackOfficeController
  before_action :set_resume, only: %i[ edit update ]

  def new
    @resume = current_user.build_resume
  end

  def edit
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
      current_user.create_resume if current_user.resume.nil?

      @resume = current_user.resume
    end

    def resume_params
      params.require(:resume).permit(:about, :loom_video_code, :calendy_code, experiences_attributes: [:id, :description, :ended_at, :started_at, :title, :skills])
    end
end
