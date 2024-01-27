# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :username, format: { with: /\A[0-9a-zA-Z\-\_]+\z/, message: "Only allows letters, numbers and _ -" }

  has_one_attached :avatar_image

  has_one :resume, -> { where(type: Resume.to_s) }, class_name: Resume.to_s
  has_many :resumes_replicas, class_name: Resumes::Replica.to_s
  has_many :devices, class_name: Users::Device.to_s

  has_many :resumes
  has_many :experiences, through: :resumes

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
