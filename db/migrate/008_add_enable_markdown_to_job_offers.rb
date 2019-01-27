class AddEnableMarkdownToJobOffers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :job_offers do |t|
      t.boolean :enable_markdown, default: false
    end
  end

  def self.down
    change_table :job_offers do |t|
      t.remove :enable_markdown
    end
  end
end
