class Game < ActiveRecord::Base
  has_many :sessions

  default_scope { order('name asc') }

  include Games::StatsRetriever
end
