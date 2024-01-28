class AddStatusToResumes < ActiveRecord::Migration[7.1]
  def change
    add_column :resumes, :status, :integer, default: 0
  end
end
