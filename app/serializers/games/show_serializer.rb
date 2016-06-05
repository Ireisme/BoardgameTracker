class Games::ShowSerializer < GameSerializer
  attributes :best_player, :worst_player

  def best_player
    {:percent => object.best_player.win_percent, :name => object.best_player.player.name }
  end

  def worst_player
    {:percent => object.worst_player.win_percent, :name => object.worst_player.player.name }
  end
end