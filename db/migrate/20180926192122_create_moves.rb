class CreateMoves < ActiveRecord::Migration[5.2]
  def change
    create_table :moves do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :position
      t.boolean :x_move
      t.timestamps
    end

    add_foreign_key :moves, :games, :column => :game_id
    add_foreign_key :moves, :players, :column => :player_id
  end
end
