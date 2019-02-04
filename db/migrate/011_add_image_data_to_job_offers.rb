class AddImageDataToJobOffers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :job_offers do |t|
      t.text :image_data
    end
  end

  def self.down
    change_table :job_offers do |t|
      t.remove :image_data
    end
  end
end
