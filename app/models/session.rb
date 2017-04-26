class Session < ActiveRecord::Base
  belongs_to :game
  
  has_many :session_players
  has_many :players, through: :session_players
end
