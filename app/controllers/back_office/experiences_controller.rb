# frozen_string_literal: true

module BackOffice
  class ExperiencesController < BackOfficeController
    before_action :set_resume, only: %i[create]

    def create
      @experience = @resume.experiences.create(title: 'New experience...')

      respond_to do |format|
        format.turbo_stream do
          if @experience.valid?
            render turbo_stream: turbo_stream.update(@resume, partial: 'back_office/resumes/form',
                                                              locals: { resume: @resume })
          else
            render turbo_stream: turbo_stream.update(:model_errors, partial: 'layouts/shared/model_errors',
                                                                    locals: { model: @experience })
          end
        end
        format.html do
          redirect_to edit_resume_path
        end
      end
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
end
