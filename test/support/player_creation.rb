module PlayerCreation
  def create_player(name = 'test')
    player = Player.new(:name => name)
    player.save
    return player
  end
end