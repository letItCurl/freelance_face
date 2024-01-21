class BackOffice::ResumesController < ApplicationController
  before_action :set_resume, only: %i[ show edit update destroy ]

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @resume.update(resume_params)
        format.html { redirect_to resume_url(@resume), notice: "Resume was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_resume
      @resume = current_user.resume.find(params[:id])
    end

    def resume_params
      params.fetch(:resume, {})
    end
end
