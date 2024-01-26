class Resume < ApplicationRecord
  belongs_to :user

  has_many :experiences, class_name: Resumes::Experience.to_s, dependent: :destroy

  store :settings, accessors: [ :meeting_link, :video_link ], suffix: true, coder: JSON
  store :recruter, accessors: [ :linkedin_link, :full_name, :image_url ], prefix: true, coder: JSON

  accepts_nested_attributes_for :experiences, reject_if: :all_blank

  validates :title, presence: :true
  validates :about, presence: :true
  validates :job_description, presence: :true, if: -> () { self.type == Resumes::Replica.to_s }
  validates :slug, presence: :true, if: -> () { self.type == Resumes::Replica.to_s }

  validate :minimum_experiences_count

  private
    def minimum_experiences_count
      if self.experiences.count == 0
        self.errors.add(:base, "Should have at least one experience")
      end
    end
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
