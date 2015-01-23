require 'spec_helper'

describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:expiration_from_now) { Date.today + 12.months }

  describe 'regular users' do
    it 'have an expiration date' do
      expect(user.expiration_date).to eq(expiration_from_now)
    end

    context 'upon login' do
      let(:past_lock) { Date.today + 1.month }
      let(:hook) { OpenProject::AccountExpiry::Hooks }
      before do
        user.expiration_date = past_lock
      end

      describe 'updates the expiration date' do
        it 'for OmniAuth logins' do
          expect(hook).to receive(:reset_user_expiration)
          OpenProject::OmniAuth::Authorization.after_login! user, {}
        end

        it 'for regular logins' do
          expect(hook).to receive(:reset_user_expiration)
          Redmine::Hook.call_hook(
            :controller_account_success_authentication_after,
            user: user
          )
        end
      end
    end
  end

  describe 'admins' do
    let(:admin) { FactoryGirl.create(:admin) }
    it 'do not expire' do
      expect(admin.expiration_date).to be_nil
    end
  end
end
