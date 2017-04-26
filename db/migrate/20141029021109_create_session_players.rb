class CreateSessionPlayers < ActiveRecord::Migration
  def change
    create_table :session_players do |t|
      t.integer :score
      t.integer :placing
      t.integer :team_number
      t.references :player, index: true
      t.references :session, index: true

      t.timestamps
    end
  end
end
