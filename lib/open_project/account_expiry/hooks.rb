module OpenProject::AccountExpiry
  class Hooks < Redmine::Hook::Listener
    # OmniAuth Hook
    def self.register_authorization_hooks
      OpenProject::OmniAuth::Authorization.after_login do |user|
        reset_user_expiration user
      end
    end

    def self.reset_user_expiration(user)
      # Update expiry date
      Rails.logger.info("Updating #{user.login}'s expiry date to #{Date.today}")
      user.set_expiration_date
      user.save
    end

    # Redmine Hook
    def controller_account_success_authentication_after(context)
      self.class.reset_user_expiration context[:user]
    end
  end
end
