class SessionSerializer < ActiveModel::Serializer
  attributes :id, :played, :game_id
end
