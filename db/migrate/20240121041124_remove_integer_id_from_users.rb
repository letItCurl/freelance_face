# frozen_string_literal: true

class RemoveIntegerIdFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :integer_id
  end
end
