class Games::ShowSerializer < GameSerializer
  attributes :best_player, :worst_player

  def best_player
    stats = object.best_player
    return nil unless stats

    {
        :percent => stats.win_percent,
        :name => stats.player.name
    }
  end

  def worst_player
    stats = object.worst_player
    return nil unless stats

    {
        :percent => stats.win_percent,
        :name => stats.player.name
    }
  end
end