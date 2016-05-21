class SessionPlayerSerializer < ActiveModel::Serializer
  attributes :id, :score, :placing, :team_number, :player_id, :session_id
end
