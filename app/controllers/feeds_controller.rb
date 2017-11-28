class FeedsController < ApplicationController
  def index
    @feed = HistoricalCap.all.order(created_at: :desc)

    get_latest_cap
  end

  def latest
    since = latest_params[:since].to_i || 0

    @feed = HistoricalCap.all.order(created_at: :desc).to_a.select {|hc| hc.created_at.to_time.to_i > since }

    get_latest_cap

    render 'latest', layout: false
  end

  private

  def latest_params
    params.permit(:since)
  end

  def get_latest_cap
    if latest = HistoricalCap.all.order(created_at: :desc).first.presence
      @latest = latest.created_at.to_time.to_i
    else
      @latest = 0
    end
  end
end
