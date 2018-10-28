class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :neo_reference_id, :user_id, :asteroid

  def asteroid

    conn = Faraday.new(url: "https://api.nasa.gov") do |faraday|
      faraday.params["api_key"] = ENV["neo_api_key"]
      faraday.adapter Faraday.default_adapter
    end
    asteroid_data = JSON.parse(conn.get("/neo/rest/v1/neo/#{object.neo_reference_id}").body, symbolize_names: true)

    { name: asteroid_data[:name],
      is_potentially_hazardous_asteroid: asteroid_data[:is_potentially_hazardous_asteroid],
    }
  end
end
