class Resumes::View < ApplicationRecord
  belongs_to :resume

  after_create :send_view_email

  private
    def send_view_email
      Resumes::ViewMailer.create(self).deliver_later
    end
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
