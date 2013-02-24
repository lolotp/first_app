class CreatePointCoordinates < ActiveRecord::Migration
  def change
    create_table :point_coordinates do |t|
      t.string :MAC
      t.integer :signal_str
	  t.integer :location_id

      t.timestamps
    end
	
	add_index :point_coordinates, :location_id
  end
end
