class AddXYCoordinatesToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :map_x_coordinates, :integer
    add_column :locations, :map_y_coordinates, :integer
  end
end
