class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.belongs_to :rider
      t.belongs_to :station
      t.integer :value
      t.timestamps
    end

    add_index(:ratings, [:rider_id, :station_id], unique: true)
  end
end
