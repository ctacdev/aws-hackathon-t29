class CreateHistoricalCaps < ActiveRecord::Migration[5.1]
  def change
    create_table :historical_caps do |t|
      t.integer :user_id
      t.text :data

      t.timestamps
    end
  end
end
