module SessionCreation

  def create_session(game, winning_players: [], losing_players: [])
    session = Session.new(:game_id => game.id)
    session.save

    winning_players.each do |winner|
      session_player = SessionPlayer.new(:session_id => session.id, :player_id => winner.id)
      session_player.placing = 1
      session_player.save
    end

    losing_players.each do |loser|
      session_player2 = SessionPlayer.new(:session_id => session.id, :player_id => loser.id)
      session_player2.placing = 2
      session_player2.save
    end
  end
end