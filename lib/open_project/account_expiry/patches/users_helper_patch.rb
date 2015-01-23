module OpenProject::AccountExpiry
  module Patches
    module UsersHelperPatch
      def self.included(base)
        base.class_eval do
          unloadable

          include InstanceMethods

          alias_method_chain :full_user_status, :expiration
        end
      end

      module InstanceMethods
        def full_user_status_with_expiration(user, include_num_failed_logins = false)
          status_line = full_user_status_without_expiration(user, include_num_failed_logins)
          if user.active? && user.expires?
            expiry_tag = I18n.t('plugin.account_expiry.expires_in', expiration_date: format_date(user.expiration_date))
            status_line +=  " (#{expiry_tag})"
          end
          status_line
        end
      end
    end
  end
end
UsersHelper.send(:include, OpenProject::AccountExpiry::Patches::UsersHelperPatch)
