class AddReferencesToResume < ActiveRecord::Migration[7.1]
  def change
    add_reference :resumes, :user, foreign_key: true, type: :uuid
  end
end
