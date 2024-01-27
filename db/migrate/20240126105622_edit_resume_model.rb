# frozen_string_literal: true

class EditResumeModel < ActiveRecord::Migration[7.1]
  def change
    add_column :resumes, :settings, :jsonb
    remove_column :resumes, :calendy_code
    remove_column :resumes, :loom_video_code
  end
end
