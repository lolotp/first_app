class AddColumnGameIdToLocation < ActiveRecord::Migration
  def up
    add_column :locations, :game_id, :integer
    add_index  :locations, :game_id
  end
  def down
    remove_column :locations, :game_id
  end
end
