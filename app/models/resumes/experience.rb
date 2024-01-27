# frozen_string_literal: true

module Resumes
  class Experience < ApplicationRecord
    Resumes::Experience::MAX_EXPERIENCES = 4
    belongs_to :resume

    validate :resume_count

    private

    def resume_count
      return unless id.nil? && (resume.experiences.count >= Resumes::Experience::MAX_EXPERIENCES)

      errors.add(:base, "Only #{Resumes::Experience::MAX_EXPERIENCES} are allowed.")
    end
  end
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
