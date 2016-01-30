# Configure these to modules as helpers in the appropriate tests.
RSpec.configure do |config|
  # Include the help for the request specs.
  config.include Devise::TestHelpers, type: :view
  config.include Devise::TestHelpers, type: :controller
end
