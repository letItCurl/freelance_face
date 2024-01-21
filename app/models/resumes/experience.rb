class Resumes::Experience < ApplicationRecord
  belongs_to :resume

  has_and_belongs_to_many :skills, class_name: Resumes::Skill.to_s

  accepts_nested_attributes_for :skills, reject_if: :all_blank
end

# == Schema Information
#
# Table name: resumes_experiences
#
#  id          :uuid             not null, primary key
#  description :text
#  ended_at    :datetime
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
