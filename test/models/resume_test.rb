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
#  id              :uuid             not null, primary key
#  about           :text
#  job_description :text
#  recruter        :jsonb
#  settings        :jsonb
#  slug            :string
#  title           :string
#  type            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :uuid
#
# Indexes
#
#  index_resumes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
