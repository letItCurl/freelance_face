class Resumes::Skill < ApplicationRecord
  validates :name, presence: true

  has_and_belongs_to_many :experiences, class_name: Resumes::Experience.to_s

  # @TODO: add name unique
end

# == Schema Information
#
# Table name: resumes_skills
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
