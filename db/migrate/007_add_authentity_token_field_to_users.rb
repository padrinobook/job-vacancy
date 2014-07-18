class AddAuthentityTokenFieldToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :authentity_token
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :authentity_token
    end
  end
end
