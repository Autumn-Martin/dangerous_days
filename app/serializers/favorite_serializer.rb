class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :neo_reference_id, :user_id, :asteroid

  def asteroid
    { name: object.asteroids.first.name,
      is_potentially_hazardous_asteroid: object.asteroids.first.is_potentially_hazardous_asteroid,
    }
  end
end
