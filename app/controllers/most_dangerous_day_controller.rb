class MostDangerousDayController < ApplicationController
  def index
    # @search = DangerousDaySearch.new(params["start_date"], params["end_date"]) #eventual goal
    def conn
      Faraday.new(url: "https://api.nasa.gov") do |faraday|
        faraday.params["api_key"] = ENV["neo_api_key"]
        faraday.params["start_date"] = params["start_date"]
        faraday.params["end_date"] = params["end_date"]
        faraday.adapter Faraday.default_adapter
      end
    end
    # binding.pry
    # response = conn.get("/neo/rest/v1/feed")
    def days
      get_json("/neo/rest/v1/feed")
    end
    def get_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)[:near_earth_objects]
    end
    # days = JSON.parse(response.body, symbolize_names: true)[:near_earth_objects]
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
    most_dangerous_day = danger_count.sort_by { |date, count| count }[-1][0]
    @most_dangerous_day = most_dangerous_day.to_s.to_datetime.strftime("%B %-d, %Y")
    @neos = filtered_date_hash[most_dangerous_day]
    @neo_count = @neos.count

    @start_date = params["start_date"].to_datetime.strftime("%B %-d, %Y")
    @end_date = params["end_date"].to_datetime.strftime("%B %-d, %Y")

    # meteor_info_array.each do |meteor|
    #   puts meteor[:name]
    #   puts meteor[:neo_reference_id]
    # end
  end
end
