class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :neo_reference_id, :user_id, :asteroid

  def asteroid
    { name: asteroid_data[:name],
      is_potentially_hazardous_asteroid: asteroid_data[:is_potentially_hazardous_asteroid],
    }
  end

  private
  def asteroid_data
    NasaAsteroidService.new(object.neo_reference_id).asteroid_attributes
  end
end
