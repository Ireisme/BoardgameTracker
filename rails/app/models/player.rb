class Player < ActiveRecord::Base
  has_many :session_players
  has_many :sessions, through: :session_player
end
