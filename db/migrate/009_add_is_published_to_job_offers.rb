class AddIsPublishedToJobOffers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :job_offers do |t|
      t.boolean :is_published, default: false
    end
  end

  def self.down
    change_table :job_offers do |t|
      t.remove :is_published
    end
  end
end
