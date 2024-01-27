class RemoveJsonb < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :settings, type: :jsonb

    change_table :resumes do |t|
      t.remove :settings, type: :jsonb
      t.remove :recruter, type: :jsonb

      t.string :meeting_url
      t.string :video_url
      t.string :location
      t.datetime :developer_since
      t.string :recuter_linkedin_url
      t.string :recuter_full_name
      t.string :recuter_image_url
      t.string :recuter_email
    end
  end
end
