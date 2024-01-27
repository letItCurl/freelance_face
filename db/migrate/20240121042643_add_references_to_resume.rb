# frozen_string_literal: true

class AddReferencesToResume < ActiveRecord::Migration[7.1]
  def change
    add_reference :resumes, :user, foreign_key: { on_delete: :cascade }, type: :uuid
  end
end
