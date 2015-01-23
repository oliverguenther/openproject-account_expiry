class AddExpiryDate < ActiveRecord::Migration
  def self.up
    add_column :users, :expiration_date, :date, null: true
  end

  def self.down
    remove_column :users, :expiration_date
  end
end
