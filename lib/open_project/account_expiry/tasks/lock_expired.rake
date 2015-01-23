namespace :account_expiry do
  desc 'Lock all accounts with expiry_date < now'
  task lock: :environment do
    locker = OpenProject::AccountExpiry::LockTask.new
    locker.perform true
  end
end
