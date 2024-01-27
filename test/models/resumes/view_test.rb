require "test_helper"

class Resumes::ViewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: resumes_views
#
#  id         :uuid             not null, primary key
#  remote_ip  :string
#  user_agent :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  resume_id  :uuid             not null
#
# Indexes
#
#  index_resumes_views_on_resume_id  (resume_id)
#
# Foreign Keys
#
#  fk_rails_...  (resume_id => resumes.id) ON DELETE => cascade
#
