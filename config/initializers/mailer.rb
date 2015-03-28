Rails.application.config.action_mailer.delivery_method = :smtp
# Make sure you change this information before deployment.
# Example:
# Rails.application.config.action_mailer.smtp_settings = {
#   :address              => 'smtp.gmail.com',
#   :port                 => 25,
#   :user_name            => 'example@gmail.com',
#   :password             => 'password',
#   :authentication       => 'plain',
#   :enable_starttls_auto => true
# }
=begin
Rails.application.config.action_mailer.smtp_settings = {
  :address              => '<YOUR_MAILER_ADDRESS>',
  :port                 => 25,
  :user_name            => '<YOUR_MAILER_USERNAME>',
  # Do not keep password in the repository.
  :password             => ENV["SMTP_MAILER_PASSWORD"],
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
=end
Rails.application.config.action_mailer.default_url_options = { host: 'example.com' }
Rails.application.config.action_mailer.smtp_settings = {
  :address              => 'smtp.yeah.net',
  :port                 => 25,
  :user_name            => 'dailab@yeah.net',
  # Do not keep password in the repository.
  :password             => 'Dailab606',
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
