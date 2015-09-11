class MetricsController < ApplicationController
  def show
    @metric = Metric.find(params[:id])
    render json: @metric.last_hours(26)
  end
end
