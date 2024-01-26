class Resume < ApplicationRecord
  belongs_to :user

  has_many :experiences, class_name: Resumes::Experience.to_s, dependent: :destroy

  store :settings, accessors: [ :meeting_link, :video_link ], suffix: true, coder: JSON

  accepts_nested_attributes_for :experiences, reject_if: :all_blank

  validates :about, presence: :true
end

# == Schema Information
#
# Table name: resumes
#
#  id         :uuid             not null, primary key
#  about      :text
#  settings   :jsonb
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid
#
# Indexes
#
#  index_resumes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
