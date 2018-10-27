class Api::V1::User::FavoritesController < ApplicationController
  def index
    render json: Favorite.all
  end
end
