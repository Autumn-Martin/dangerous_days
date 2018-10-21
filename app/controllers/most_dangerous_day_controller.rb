class MostDangerousDayController < ApplicationController
  def index
    @conn = Faraday.new(url: "https://api.nasa.gov") do |faraday|
      faraday.params["api_key"] = ENV["neo_api_key"]
      faraday.params["start_date"] = "2018-01-01"
      faraday.params["end_date"] = "2018-01-07"
      faraday.adapter Faraday.default_adapter
    end

    response = @conn.get("/neo/rest/v1/feed")
    days = JSON.parse(response.body, symbolize_names: true)[:near_earth_objects]
    filtered_date_hash = {}
    days.each do |date, info_array|
      filtered_date_hash[date] = info_array.select do |hash|
        hash[:is_potentially_hazardous_asteroid]
      end
    end
    danger_count = {}
    filtered_date_hash.each do |date, info_array|
      danger_count[date] = info_array.count
    end
    # binding.pry
    most_dangerous_day = danger_count.sort_by { |date, count| count }[-1][0]
    @most_dangerous_day = most_dangerous_day.to_s
    # binding.pry
    @neos = filtered_date_hash[most_dangerous_day]
    @neo_count = @neos.count
    # binding.pry
    @start_date = params["start_date"]
    @end_date = params["end_date"]

    # meteor_info_array.each do |meteor|
    #   puts meteor[:name]
    #   puts meteor[:neo_reference_id]
    #
  end
end
