class BackOffice::ResumesReplicasController < BackOfficeController
  before_action :set_resume, only: %i[ show edit update destroy ]

  def index
    @resumes_replicas = current_user.resumes_replicas.all
    @resume = current_user.resume
  end

  def show
  end

  def edit
  end

  def create
    @resume = current_user.resumes_replicas.new(resume_params)

    respond_to do |format|
      if @resume.save
        format.html { redirect_to resumes_path, notice: "Resume was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @resume.update(resume_params)
        format.html { redirect_to resumes_replicas_path(@resume), notice: "Resume was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @resume.destroy!

    respond_to do |format|
      format.html { redirect_to resumes_url, notice: "Resume was successfully destroyed." }
    end
  end

  private
    def set_resume
      @resume = current_user.resumes_replicas.find(params[:id])
    end

    def resume_params
      params.fetch(:resume, {})
    end
end
