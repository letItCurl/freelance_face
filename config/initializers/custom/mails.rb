# Assign the from email address in all environments
Rails.application.reloader.to_prepare do
  if Rails.env.production? || Rails.env.staging?
    ActionMailer::Base.default_url_options[:host] = "freelanceface.com"
    ActionMailer::Base.smtp_settings.merge!({
      :address=>"smtp-relay.sendinblue.com",
      :port=>587,
      :domain=>"freelanceface.com",
      :user_name=>Rails.application.credentials[:sendinblue][:username],
      :password=>Rails.application.credentials[:sendinblue][:password],
      :authentication=>"login",
      :enable_starttls_auto=>true,
      :open_timeout=>5,
      :read_timeout=>5
    })
  end
end
