class CreateUserLocationRelations < ActiveRecord::Migration
  def change
    create_table :user_location_relations do |t|
      t.integer :user_id
      t.integer :location_id

      t.timestamps
    end
    add_index :user_location_relations, :user_id
    add_index :user_location_relations, :location_id
  end
end
