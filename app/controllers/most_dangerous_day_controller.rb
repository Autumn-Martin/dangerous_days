class MostDangerousDayController < ApplicationController
  def index
    # @search = DangerousDaySearch.new(params["start_date"], params["end_date"])
    @search = DangerousDayFacade.new(params["start_date"], params["end_date"])
  end
end
