class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :description
      t.string :map_image
      t.integer :user_id

      t.timestamps
    end
    add_index :games, :user_id
  end
end
