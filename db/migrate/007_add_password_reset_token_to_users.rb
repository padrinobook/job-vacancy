class AddPasswordResetTokenToUsers < ActiveRecord::Migration[4.2]
  def self.up
    change_table :users do |t|
      t.string :password_reset_token, default: 0, null: true
      t.datetime :password_reset_sent_date, default: 0, null: true
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :password_reset_token
      t.remove :password_reset_sent_date
    end
  end
end
