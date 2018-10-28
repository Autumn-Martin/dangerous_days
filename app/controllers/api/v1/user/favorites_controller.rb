class Api::V1::User::FavoritesController < ApplicationController
  def index
    render json: Favorite.all
  end

  def create
    render json: Favorite.create(favorite_params)
  end

  private

  def favorite_params
    params.require(:favorite).permit(:neo_reference_id, :user_id)
  end
end
