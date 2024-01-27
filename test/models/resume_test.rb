# frozen_string_literal: true

require 'test_helper'

class ResumerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: resumes
#
#  id                    :uuid             not null, primary key
#  about                 :text
#  developer_since       :datetime
#  job_description       :text
#  location              :string
#  meeting_url           :string
#  recruter_email        :string
#  recruter_full_name    :string
#  recruter_image_url    :string
#  recruter_linkedin_url :string
#  slug                  :string
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
