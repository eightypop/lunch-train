class CreateTrains < ActiveRecord::Migration
  def change
    create_table :trains do |t|

      t.datetime :depart_time
      t.timestamps
      t.belongs_to :station


    end

    create_join_table :trains, :riders
  end
end
