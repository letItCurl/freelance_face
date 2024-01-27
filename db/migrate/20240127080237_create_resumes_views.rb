class CreateResumesViews < ActiveRecord::Migration[7.1]
  def change
    create_table :resumes_views, id: :uuid do |t|
      t.references :resume, null: false, foreign_key: {on_delete: :cascade}, type: :uuid
      t.string :remote_ip
      t.string :user_agent

      t.timestamps
    end
  end
end
