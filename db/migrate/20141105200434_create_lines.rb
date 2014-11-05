class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :name
      t.string :time_zone

      t.timestamps
    end
  end
end
