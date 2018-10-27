class AsteroidSerializer < ActiveModel::Serializer
  attributes :name, :is_potentially_hazardous_asteroid
end
