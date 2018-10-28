class Asteroid < ApplicationRecord
  belongs_to :favorite
  validates_presence_of :name
end
