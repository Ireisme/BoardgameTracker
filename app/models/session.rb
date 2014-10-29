class Session < ActiveRecord::Base
  belongs_to :game
  
  has_many :session_player
  has_many :player,  through: :session_player
end
