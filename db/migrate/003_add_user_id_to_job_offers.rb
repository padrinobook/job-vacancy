class AddUserIdToJobOffers < ActiveRecord::Migration
  def self.up
    change_table :job_offers do |t|
      t.integer :user_id
    end
  end

  def self.down
    change_table :job_offers do |t|
      t.remove :user_id
    end
  end
end
