# frozen_string_literal: true

class Resume < ApplicationRecord
  belongs_to :user

  has_many :experiences, class_name: Resumes::Experience.to_s, dependent: :destroy
  has_many :views, class_name: Resumes::View.to_s, dependent: :destroy

  has_one_attached :avatar_image

  accepts_nested_attributes_for :experiences, reject_if: :all_blank
  accepts_nested_attributes_for :user, update_only: true

  validates :title, presence: true
  validates :about, presence: true
  validates :location, presence: true
  validates :developer_since, presence: true
  validates :job_description, presence: true, if: -> { type == Resumes::Replica.to_s }
  validates :slug, format: { with: /\A[0-9a-zA-Z\-\_]+\z/, message: "Only allows letters, numbers and _ -" }, if: -> () { self.slug.present? }

  validate :minimum_experiences_count

  def recruter_image_url
    super.blank? ? 'https://static.licdn.com/aero-v1/sc/h/9c8pery4andzj6ohjkjp54ma2' : super
  end

  private

  def minimum_experiences_count
    return unless experiences.count.zero? && persisted?

    errors.add(:base, 'Should have at least one experience')
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
