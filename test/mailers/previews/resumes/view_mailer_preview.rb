# Preview all emails at http://localhost:3000/rails/mailers/resumes/view_mailer
class Resumes::ViewMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/resumes/view_mailer/create
  def create
    Resumes::ViewMailer.create(Resumes::View.first)
  end
end
