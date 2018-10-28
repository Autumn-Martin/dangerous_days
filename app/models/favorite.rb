class Favorite < ApplicationRecord
  belongs_to :user
  has_many :asteroids
end
