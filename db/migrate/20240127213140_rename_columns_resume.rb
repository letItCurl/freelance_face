class RenameColumnsResume < ActiveRecord::Migration[7.1]
  def change
    remove_column :resumes, :recuter_linkedin_url
    remove_column :resumes, :recuter_full_name
    remove_column :resumes, :recuter_image_url
    remove_column :resumes, :recuter_email

    add_column :resumes, :recruter_linkedin_url, :string
    add_column :resumes, :recruter_full_name, :string
    add_column :resumes, :recruter_image_url, :string
    add_column :resumes, :recruter_email, :string
  end
end
