require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Historical
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('app', 'forms')

     config.to_prepare do
       Devise::SessionsController.layout 'simple'
       Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? 'application' : 'simple' }
       Devise::ConfirmationsController.layout 'simple'
       Devise::UnlocksController.layout 'simple'
       Devise::PasswordsController.layout 'simple'
     end
  end
end
