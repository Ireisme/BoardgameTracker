class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.text :powers

      t.timestamps
    end
  end
end
