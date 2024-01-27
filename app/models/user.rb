class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  store :settings, accessors: [ :image_url ], suffix: true, coder: JSON

  has_one :resume, -> { where(type: Resume.to_s) }, class_name: Resume.to_s
  has_many :resumes_replicas, class_name: Resumes::Replica.to_s

  has_many :resumes
  has_many :experiences, through: :resumes

  def gravatar_url
    hash = Digest::MD5.hexdigest(self.email&.downcase || "")
    options.reverse_merge!(default: :mp, rating: :pg)
    "https://secure.gravatar.com/avatar/#{hash}.png?#{options.to_param}"
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
