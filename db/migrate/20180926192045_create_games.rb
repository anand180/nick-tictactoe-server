class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :x_player_id
      t.integer :o_player_id, :null => true
      t.boolean :completed, :default => false
      t.boolean :x_first
      t.timestamps
    end

    add_foreign_key :games, :players, :column => :x_player_id
    add_foreign_key :games, :players, :column => :o_player_id
  end
end
