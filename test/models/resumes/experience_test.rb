require "test_helper"

class Resumes::ExperienceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: resumes_experiences
#
#  id          :uuid             not null, primary key
#  description :text
#  ended_at    :datetime
#  skills      :text
#  started_at  :datetime
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  resume_id   :uuid
#
# Indexes
#
#  index_resumes_experiences_on_resume_id  (resume_id)
#
# Foreign Keys
#
#  fk_rails_...  (resume_id => resumes.id) ON DELETE => cascade
#
