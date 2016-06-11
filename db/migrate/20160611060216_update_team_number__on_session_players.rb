class UpdateTeamNumberOnSessionPlayers < ActiveRecord::Migration
  def change
    change_column :session_players, :team_number, :string
  end
end
