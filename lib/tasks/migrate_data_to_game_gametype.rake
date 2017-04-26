require 'rake'

task :migrate_data_to_game_gametype => :environment do
  desc "Update co-op games to co-op game type"
  games = Game.where(coop: true)

  puts "Going to update #{games.count} games"
  ActiveRecord::Base.transaction do
    games.each do |game|
      game.update_attributes!(:game_type => Game.game_types[:coop])
    end
  end
end