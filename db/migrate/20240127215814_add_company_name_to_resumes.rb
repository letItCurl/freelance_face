class AddCompanyNameToResumes < ActiveRecord::Migration[7.1]
  def change
    add_column :resumes, :company_name, :string
  end
end
