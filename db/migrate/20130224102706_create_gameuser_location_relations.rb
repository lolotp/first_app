class CreateGameuserLocationRelations < ActiveRecord::Migration
  def change
    create_table :gameuser_location_relations do |t|
      t.integer :game_user_relation_id
      t.integer :location_id

      t.timestamps
    end
    add_index :gameuser_location_relations, :game_user_relation_id
    add_index :gameuser_location_relations, :location_id
  end
end
