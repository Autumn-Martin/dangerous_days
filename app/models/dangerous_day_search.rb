class DangerousDaySearch
  attr_reader :start_date, :end_date
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
    @most_dangerous_day = most_dangerous_day.to_s.to_datetime.strftime("%B %-d, %Y")
  end

  def most_dangerous_day
    danger_counts = {}
    haz_days_data.each do |date, info_array|
      danger_counts[date] = info_array.count
    end
    danger_counts.sort_by { |date, count| count }[-1][0]
  end

  def neos
    data = haz_days_data[most_dangerous_day]
    @neos = data.map do |neo_data|
      Neo.new(neo_data)
    end
  end

  private

  def haz_days_data
    filtered_date_hash = {}
    service.days.each do |date, info_array|
      filtered_date_hash[date] = potentially_hazardous?(info_array)
    end
  end

  def potentially_hazardous?(info_array)
    info_array.select do |hash|
      hash[:is_potentially_hazardous_asteroid]
    end
  end

  def service
    NasaNeoService.new(@start_date, @end_date)
  end

end
