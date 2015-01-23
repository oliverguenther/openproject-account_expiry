module OpenProject::AccountExpiry
  class LockTask
    ##
    # Create lock task for accounts expired before `date`.
    # Does not perform any locking.
    def initialize(date = Date.today)
      @date = date
    end

    def lockdate
      @date
    end

    ##
    # Perform the lock requested in this task
    def perform(verbose = false)
      affected = User.where(
        'expiration_date IS NOT NULL AND expiration_date <= ?',
        lockdate
      )

      if affected.empty? && verbose
        puts 'No users eligible for locking.'
      end

      affected.each do |user|
        puts "Locking user #{user.login} (##{user.id})" if verbose
        user.lock! unless user.locked?
      end

      affected
    end
  end
end
