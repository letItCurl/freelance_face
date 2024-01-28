# frozen_string_literal: true

module Resumes
  class Replica < Resume
    belongs_to :user
  end
end

# == Schema Information
#
# Table name: resumes
#
#  id                    :uuid             not null, primary key
#  about                 :text
#  company_name          :string
#  developer_since       :datetime
#  job_description       :text
#  location              :string
#  meeting_url           :string
#  recruter_email        :string
#  recruter_full_name    :string
#  recruter_image_url    :string
#  recruter_linkedin_url :string
#  slug                  :string
#  status                :integer          default("not_started")
#  title                 :string
#  type                  :string
#  video_url             :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :uuid
#
# Indexes
#
#  index_resumes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
