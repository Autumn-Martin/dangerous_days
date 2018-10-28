class NasaNeoDateService
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def conn
    Faraday.new(url: "https://api.nasa.gov") do |faraday|
      faraday.params["api_key"] = ENV["neo_api_key"]
      faraday.params["start_date"] = @start_date
      faraday.params["end_date"] = @end_date
      faraday.adapter Faraday.default_adapter
    end
  end

  def days
    get_json("/neo/rest/v1/feed")
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)[:near_earth_objects]
  end

end
