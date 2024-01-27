# frozen_string_literal: true

class CreateResumesExperiences < ActiveRecord::Migration[7.1]
  def change
    create_table :resumes_experiences, id: :uuid do |t|
      t.string :title
      t.text :description
      t.text :skills
      t.datetime :started_at
      t.datetime :ended_at
      t.references :resume, foreign_key: { on_delete: :cascade }, type: :uuid
      t.timestamps
    end
  end
end
