class CreateJoinTableResumesExperiencesSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :resumes_experiences_skills, id: :uuid do |t|
      t.uuid :skill_id
      t.uuid :experience_id
    end

    add_index :resumes_experiences_skills, :skill_id
    add_index :resumes_experiences_skills, :experience_id
  end
end
