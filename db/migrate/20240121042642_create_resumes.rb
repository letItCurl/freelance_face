class CreateResumes < ActiveRecord::Migration[7.1]
  def change
    create_table :resumes, id: :uuid do |t|
      t.text :about
      t.jsonb :experiences
      t.jsonb :skills
      t.text :calendy_code
      t.text :loom_video_code
      t.string :type

      t.timestamps
    end
  end
end
