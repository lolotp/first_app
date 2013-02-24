class CreateGameUserRelations < ActiveRecord::Migration
  def change
    create_table :game_user_relations do |t|
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
    add_index :game_user_relations, :user_id
    add_index :game_user_relations, :game_id
  end
end
