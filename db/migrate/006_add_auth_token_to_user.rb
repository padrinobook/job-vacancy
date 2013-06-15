class AddAuthTokenToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :auth_token
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :auth_token
    end
  end

end
