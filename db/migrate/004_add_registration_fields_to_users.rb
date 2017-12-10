class AddRegistrationFieldsToUsers < ActiveRecord::Migration[4.2]
  @fields = [:password]

  def self.up
    change_table :users do |t|
      @fields.each { |field| t.string field}
    end
  end

  def self.down
    change_table :users do |t|
      @fields.each { |field| remove_column field}
    end
  end
end
