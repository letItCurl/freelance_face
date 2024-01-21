class RemoveExperiencesAndSkillsFromResumer < ActiveRecord::Migration[7.1]
  def change
    remove_column :resumes, :experiences
    remove_column :resumes, :skills

    add_column :resumes, :content, :jsonb, default: {}
  end
end
