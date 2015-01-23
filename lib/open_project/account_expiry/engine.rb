module OpenProject::AccountExpiry
  class Engine < ::Rails::Engine
    engine_name :openproject_account_expiry

    include OpenProject::Plugins::ActsAsOpEngine

    def self.settings
      { partial: 'settings/openproject_account_expiry',
        default: {
          # Months added from login until expiry
          months_until_expiry: 12,
        }
      }
    end

    register(
      'openproject-account_expiry',
      author_url: 'https://github.com/oliverguenther/openproject_account_expiry',
      requires_openproject: '>= 4.0.0',
      settings: settings
    )

    patches [:User, :UsersHelper]

    # Loading additional rake task
    rake_tasks do
      base = File.dirname(__FILE__)
      load File.join(base, '/tasks/lock_expired.rake')
    end

    # Register hooks
    initializer 'account_expiry.hooks' do
      require_dependency 'open_project/account_expiry/hooks'
      OpenProject::AccountExpiry::Hooks.register_authorization_hooks
    end
  end
end
