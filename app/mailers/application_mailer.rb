class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.config.action_mailer.smtp_settings[:user_name]
  layout 'mailer'
end
