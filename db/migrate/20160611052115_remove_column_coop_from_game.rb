class RemoveColumnCoopFromGame < ActiveRecord::Migration
  def change
    Rake::Task['migrate_data_to_game_gametype'].invoke
    remove_column :games, :coop, :boolean
  end
end
