module MoveCreator
   def self.add_three_non_winning_moves(game:)
     type = game.x_first ? 'x' : 'o'

     class << type
       @@counter = 0
       def switch
         type = @@counter.even? ? 'o' : 'x'
         @@counter += 1; type
       end
     end

     Move.create(game_id: game.id, player_id: game.send("#{type}_player_id"), position: 0)
     Move.create(game_id: game.id, player_id: game.send("#{type.switch}_player_id"), position: 1)
     Move.create(game_id: game.id, player_id: game.send("#{type.switch}_player_id"), position: 2)
   end
end
