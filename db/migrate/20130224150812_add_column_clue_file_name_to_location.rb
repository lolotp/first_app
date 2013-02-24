class AddColumnClueFileNameToLocation < ActiveRecord::Migration
  def change
	add_column :locations, :clue_file_name, :string
  end
end
