class Games::ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :image
end