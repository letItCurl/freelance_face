# frozen_string_literal: true

class AddJobDescriptionAndRecruterAndSlugToResumes < ActiveRecord::Migration[7.1]
  def change
    add_column :resumes, :job_description, :text
    add_column :resumes, :recruter, :jsonb
    add_column :resumes, :slug, :string
    add_column :resumes, :title, :string
  end
end
