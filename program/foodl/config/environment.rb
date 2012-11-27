# Load the rails application
require File.expand_path('../application', __FILE__)

Foodl::Application.configure do
  config.action_controller.session_store = :active_record_store
end

# Initialize the rails application
Foodl::Application.initialize!

