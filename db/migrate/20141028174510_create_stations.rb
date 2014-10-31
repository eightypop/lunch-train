class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.decimal :lat, precision: 15, scale: 10
      t.decimal :lon, precision: 15, scale: 10
      t.boolean :open, default: true
      t.timestamps
    end
  end
end
