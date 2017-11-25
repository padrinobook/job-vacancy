class AddConfirmationTokenAndConfirmationToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :confirmation_token
      t.boolean :confirmation, default: false
    end
  end

  def self.down
    change_table :users do |t|
      t.remove_column :confirmation_token, :confirmation
    end
  end
end

