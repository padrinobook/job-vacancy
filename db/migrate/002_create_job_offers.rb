class CreateJobOffers < ActiveRecord::Migration
  def self.up
    create_table :job_offers do |t|
      t.string :title
      t.string :location
      t.text :description
      t.string :contact
      t.date :time_start
      t.date :time_end
      t.timestamps
    end
  end

  def self.down
    drop_table :job_offers
  end
end
