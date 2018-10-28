class Api::V1::User::FavoritesController < ApplicationController
  def index

    conn = Faraday.new(url: "https://api.nasa.gov") do |faraday|
      faraday.params["api_key"] = ENV["neo_api_key"]
      faraday.adapter Faraday.default_adapter
    end

    Favorite.all.map do |fave|
      asteroid_data = JSON.parse(conn.get("/neo/rest/v1/neo/#{fave.neo_reference_id}").body, symbolize_names: true)
      # binding.pry
      Asteroid.create(name: asteroid_data[:name], neo_reference_id:asteroid_data[:neo_reference_id], is_potentially_hazardous_asteroid: asteroid_data[:is_potentially_hazardous_asteroid], favorite_id: fave.id)
    end

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
