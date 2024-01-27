# frozen_string_literal: true

class RemoveJsonbFromResume < ActiveRecord::Migration[7.1]
  def change
    remove_column :resumes, :content
  end
end
