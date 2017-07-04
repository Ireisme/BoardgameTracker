class Game < ActiveRecord::Base
  has_many :sessions
  enum game_type: {
      mixed: 0,
      competitive: 1,
      coop: 2
  }

  include Games::StatsRetriever
end
