# frozen_string_literal: true
# Configure these to modules as helpers in the appropriate tests.
RSpec.configure do |config|
  # Include the help for the request specs.
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::Test::ControllerHelpers, type: :controller
end
