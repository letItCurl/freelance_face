class BackOffice::SkillsController < BackOfficeController
  before_action :set_experience, only: %i[ create destroy ]

  def create
    @skill = @experience.create(skill_params)
  end

  def destroy

  end

  private
    def skill_params
      params.require(:skill).permit(:name)
    end

    def set_experience
      @experience = current_user.experiences.find(params[:id])
    end
end
