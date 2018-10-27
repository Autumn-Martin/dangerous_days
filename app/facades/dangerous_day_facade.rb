class DangerousDayFacade
  attr_reader :formatted_start_date, :formatted_end_date

  def initialize(start_date, end_date)
    @start_date = start_date
    @formatted_start_date = start_date.to_datetime.strftime("%B %-d, %Y")
    @end_date = end_date
    @formatted_end_date = end_date.to_datetime.strftime("%B %-d, %Y")
    @most_dangerous_day = most_dangerous_day.to_s.to_datetime.strftime("%B %-d, %Y")
  end

  def most_dangerous_day
    @most_dangerous_day ||= DangerousDaySearch.new(@start_date, @end_date).most_dangerous_day
  end

  def neos
    @neos ||= DangerousDaySearch.new(@start_date, @end_date).neos
  end
end
