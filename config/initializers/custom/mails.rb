# Assign the from email address in all environments
Rails.application.reloader.to_prepare do
  if Rails.env.production? || Rails.env.staging?
    ActionMailer::Base.default_url_options[:host] = "freelance-resume.rolandsoftwares.com"
    ActionMailer::Base.smtp_settings.merge!({
      :address=>"smtp-relay.sendinblue.com",
      :port=>587,
      :domain=>"freelance-resume.rolandsoftwares.com",
      :user_name=>Rails.application.credentials.dig(:sendinblue, :username),
      :password=>Rails.application.credentials.dig(:sendinblue, :password),
      :authentication=>"login",
      :enable_starttls_auto=>true,
      :open_timeout=>5,
      :read_timeout=>5
    })
  end
end
