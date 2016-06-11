class Game < ActiveRecord::Base
  has_many :sessions
  enum game_type: {
      mixed: 0,
      competitive: 1,
      coop: 2
  }

  default_scope { order('name asc') }

  include Games::StatsRetriever
end
