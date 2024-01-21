class CreateResumesSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :resumes_skills, id: :uuid do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
