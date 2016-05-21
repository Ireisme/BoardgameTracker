class GameSerializer < ActiveModel::Serializer
  attributes :id, :name, :coop, :description, :image
end
