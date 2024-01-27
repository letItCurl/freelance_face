class Resumes::ViewMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.resumes.view_mailer.create.subject
  #

  def create(view)
    @view = view
    @resume = view.resume

    mail to: @resume.user.email, from: "Roland <roland@nomadjoker.com>", subject: "Resume Opened ⚡️"
  end
end
