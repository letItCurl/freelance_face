class CreateUsersDevices < ActiveRecord::Migration[7.1]
  def change
    create_table :users_devices, id: :uuid do |t|
      t.references :user, null: false, foreign_key: {on_delete: :cascade}, type: :uuid
      t.string :remote_ip
      t.string :user_agent

      t.timestamps
    end
  end
end
