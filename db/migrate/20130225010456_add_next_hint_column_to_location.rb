class AddNextHintColumnToLocation < ActiveRecord::Migration
  def change
	add_column :locations, :next_hint, :string
  end
end
