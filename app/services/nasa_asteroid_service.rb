class NasaAsteroidService
  def initialize(neo_reference_id)
    @neo_reference_id = neo_reference_id
  end

  def conn
    Faraday.new(url: "https://api.nasa.gov") do |faraday|
      faraday.params["api_key"] = ENV["neo_api_key"]
      faraday.adapter Faraday.default_adapter
    end
  end

  def asteroid_attributes
    JSON.parse(conn.get("/neo/rest/v1/neo/#{@neo_reference_id}").body, symbolize_names: true)
  end
end
