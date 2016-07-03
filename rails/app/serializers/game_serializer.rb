class GameSerializer < ActiveModel::Serializer
  attributes :id, :name, :game_type, :description, :image
end
