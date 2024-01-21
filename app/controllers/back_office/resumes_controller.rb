class BackOffice::ResumesController < ApplicationController
  before_action :set_back_office_resume, only: %i[ show edit update destroy ]

  def index
    @resumes = Resume.all
  end

  def show
  end

  def new
    @resume = Resume.new
  end

  def edit
  end

  def create
    @resume = Resume.new(resume_params)

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
        format.html { redirect_to resume_path(@resume), notice: "Resume was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @resume.destroy!

    respond_to do |format|
      format.html { redirect_to back_office_resumes_url, notice: "Resume was successfully destroyed." }
    end
  end

  private
    def set_back_office_resume
      @resume = Resume.find(params[:id])
    end

    def resume_params
      params.fetch(:resume, {})
    end
end
