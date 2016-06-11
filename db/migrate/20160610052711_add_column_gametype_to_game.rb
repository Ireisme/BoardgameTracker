class AddColumnGametypeToGame < ActiveRecord::Migration
  def up
    add_column :games, :game_type, :integer, :null => false, default: 1
    change_column_default :games, :game_type, nil
  end

  def down
    remove_column :games, :game_type
  end
end
