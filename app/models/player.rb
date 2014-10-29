class Player < ActiveRecord::Base
  has_many :session_player
  has_many :session, through: :session_player
end
