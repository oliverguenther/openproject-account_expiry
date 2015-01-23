# Avoid load-order issues
require_dependency 'principal'
require_dependency 'user'
require_dependency 'project'
module OpenProject::AccountExpiry
  module Patches
    module UserPatch
      def self.included(base)
        base.class_eval do
          unloadable

          include InstanceMethods

          before_create :set_expiration_date
        end
      end

      module InstanceMethods
        def set_expiration_date
          if !admin?
            expires_in = Setting.plugin_openproject_account_expiry[:months_until_expiry]
            self.expiration_date = Date.today + expires_in.months
          end
        end

        def expires?
          !(admin? || expiration_date.nil?)
        end
      end
    end
  end
end
User.send(:include, OpenProject::AccountExpiry::Patches::UserPatch)
