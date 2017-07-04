module GameCreation
  def create_game(name = 'test')
    game = Game.new(:name => name, :game_type => Game.game_types[:mixed])
    game.save
    return game
  end
end