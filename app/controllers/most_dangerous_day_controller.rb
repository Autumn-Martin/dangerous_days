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

    def days
      get_json("/neo/rest/v1/feed")
    end

    def get_json(url)
      JSON.parse(conn.get(url).body, symbolize_names: true)[:near_earth_objects]
    end

    def haz_days_data
      filtered_date_hash = {}
      days.each do |date, info_array|
        binding.pry
        filtered_date_hash[date] = potentially_hazardous?(info_array)
      end
    end
    def potentially_hazardous?(info_array)
      info_array.select do |hash|
        hash[:is_potentially_hazardous_asteroid]
      end
    end

    def most_dangerous_day
      danger_counts = {}
      haz_days_data.each do |date, info_array|
        danger_counts[date] = info_array.count
      end
      danger_counts.sort_by { |date, count| count }[-1][0]
    end

    @most_dangerous_day = most_dangerous_day.to_s.to_datetime.strftime("%B %-d, %Y")
    @neos = haz_days_data[most_dangerous_day]
    @neo_count = @neos.count

    @start_date = params["start_date"].to_datetime.strftime("%B %-d, %Y")
    @end_date = params["end_date"].to_datetime.strftime("%B %-d, %Y")

    # meteor_info_array.each do |meteor|
    #   puts meteor[:name]
    #   puts meteor[:neo_reference_id]
    # end
  end
end
