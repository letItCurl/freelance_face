# frozen_string_literal: true

module BackOffice
  class ResumesController < BackOfficeController
    before_action :set_resume, only: %i[edit update]

    def edit
      return unless @is_onboarding_resume

      flash.now[:notice] = "We initalized a fresh resume for you. Click 'Back to resume'"
    end

    def update
      respond_to do |format|
        if @resume.update(resume_params)
          format.html { redirect_to resume_url, notice: 'Resume was successfully updated.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_resume
      create_resume if current_user.resume.nil?

      @resume = current_user.resume
    end

    def create_resume
      @is_onboarding_resume = true
      current_user.create_resume(**ONBOARDING_RESUME)
    end

    def resume_params
      params.require(:resume).permit(:title,
                                     :about,
                                     :developer_since,
                                     :location,
                                     :meeting_url,
                                     :video_url,
                                     :slug,
                                     user_attributes: [
                                      :id,
                                      :avatar_image,
                                      :first_name,
                                      :last_name,
                                      :username
                                     ],
                                     experiences_attributes: %i[
                                       id
                                       description
                                       ended_at
                                       started_at
                                       title
                                       skills
                                     ])
    end
  end
end
