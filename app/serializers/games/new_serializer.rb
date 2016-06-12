class Games::NewSerializer < GameSerializer
  attributes :game_types

  def game_types
    Game.game_types
  end
end