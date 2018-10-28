class MostDangerousDayController < ApplicationController
  def index
    @search = DangerousDayFacade.new(params["start_date"], params["end_date"])
  end
end
