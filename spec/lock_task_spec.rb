require 'spec_helper'

describe OpenProject::AccountExpiry::LockTask do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user) }
  let(:expired_user) { FactoryGirl.create(:user) }
  before do
    expired_user.update_attributes!(expiration_date: Date.today - 1.month)
  end

  let(:locktask) { OpenProject::AccountExpiry::LockTask.new }

  context 'default task' do
    it 'uses today as default' do
      expect(locktask.lockdate).to eq(Date.today)
    end

    it 'locks an expired user' do
      expect(expired_user.locked?).to eq(false)
      expect(expired_user.expiration_date).to eq(Date.today - 1.month)

      # Do the locking
      affected = locktask.perform

      expect(affected.length).to eq(1)
      expect(affected.first).to eq(expired_user)
      expect(affected.first.locked?).to eq(true)
    end
  end

  context 'custom task' do
    let(:date) { Date.today - 3.month }
    let(:locktask) { OpenProject::AccountExpiry::LockTask.new date }
    it 'uses the given date' do
      expect(locktask.lockdate).to eq(date)
    end

    it 'does not return any expired users' do
      affected = locktask.perform
      expect(affected).to be_empty
    end
  end
end
