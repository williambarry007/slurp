
Slurp.setup do |config|
  
  # From email address for all slurp emails
  config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"

  # Spice up your passwords with a salt
  config.salt = "Please add some spice to your passwords."

  # Password range length
  config.password_length = 8..128

end
