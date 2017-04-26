class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      :id
      t.string :name
      t.text :description
      t.boolean :coop

      t.timestamps
    end
  end
end
