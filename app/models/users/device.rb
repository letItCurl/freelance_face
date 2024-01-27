class Users::Device < ApplicationRecord
  belongs_to :user
end

# == Schema Information
#
# Table name: users_devices
#
#  id         :uuid             not null, primary key
#  remote_ip  :string
#  user_agent :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_users_devices_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
