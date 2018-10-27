class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :neo_reference_id, :user_id, :asteroid

  def asteroid
    object.asteroids
  end
end
