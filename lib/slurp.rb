require 'rails'
require 'active_support/dependencies'

module Slurp

  # Range validation for password length
  mattr_accessor :password_length
  @@password_length = 6..128

  # Used to encrypt password.
  mattr_accessor :salt
  @@salt = nil

  # Address which sends Slurp e-mails.
  mattr_accessor :mailer_sender
  @@mailer_sender = nil

  # The parent controller all Slurp controllers inherits from.
  # Defaults to ApplicationController. This should be set early
  # in the initialization process and should be set to a string.
  mattr_accessor :parent_controller
  @@parent_controller = "ApplicationController"

  # The parent mailer all Slurp mailers inherit from.
  # Defaults to ActionMailer::Base. This should be set early
  # in the initialization process and should be set to a string.
  mattr_accessor :parent_mailer
  @@parent_mailer = "ActionMailer::Base"

  # Default way to setup Slurp. Run rails generate slurp_install to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end

  def self.whats_my_name
    puts "My name is slurp."
  end
  
end
