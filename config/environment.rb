# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
E::Application.initialize!

ENV['RECAPTCHA_PUBLIC_KEY'] = '6Lffp78SAAAAAPgtsdGuOTlmfWUr1RwuLslU65XR'
ENV['RECAPTCHA_PRIVATE_KEY'] = '6Lffp78SAAAAAC1V40xeccxgrP43JaZkz1zSz16i'