# frozen_string_literal: true

module BackOffice
  class ResumesReplicasController < BackOfficeController
    before_action :set_resume_replica, only: %i[show edit update destroy]

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
      ONBOARDING_RESUME_REPLICA.keys.each do |key|
        @resumes_replica.public_send("#{key}=", ONBOARDING_RESUME_REPLICA[key])
      end
      @resumes_replica.recruter_image_url = "#{Rails.env.production? ? 'https://freelance-resume.rolandsoftwares.com/' : 'http://localhost:3000/'}elon_musk.jpeg"
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
          if @resumes_replica.not_started?
            ResumesReplicas::GenerateJob.perform_async(@resumes_replica.id)
            @resumes_replica.processing!
          end
          format.html { redirect_to resumes_replica_path(@resumes_replica), notice: 'Resume was successfully created.' }
        else
          format.turbo_stream { render turbo_stream: turbo_stream.update(:model_errors, partial: 'layouts/shared/model_errors', locals: { model: @resumes_replica }) }
        end
      end
    end

    def update
      respond_to do |format|
        if @resume_replica.update(resume_params)
          format.html { redirect_to resumes_replica_path(@resume_replica), notice: 'Resume was successfully updated.' }
        else
          format.turbo_stream { render turbo_stream: turbo_stream.update(:model_errors, partial: 'layouts/shared/model_errors', locals: { model: @resume_replica }) }
        end
      end
    end

    def destroy
      if @resume_replica.destroy
        redirect_to resumes_replicas_path, notice: "Resume deleted"
      else
        render :show
      end
    end

    private

    def set_resume_replica
      @resume_replica = current_user.resumes_replicas.find(params[:id])
    end

    def resume_params
      params.require(:resumes_replica).permit(:title,
        :about,
        :recruter_email,
        :recruter_full_name,
        :company_name,
        :recruter_image_url,
        :avatar_image,
        :location,
        :developer_since,
        :meeting_url,
        :video_url,
        :job_description,
        experiences_attributes: %i[
                                       id
                                       description
                                       ended_at
                                       started_at
                                       title
                                       skills
                                     ]
      )
    end
  end
end
