# Load the rails application
require File.expand_path('../application', __FILE__)

ActionMailer::Base.delivery_method = :smtp

# Don't care if the mailer can't send
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true

# Initialize the rails application
Foodl::Application.initialize!

