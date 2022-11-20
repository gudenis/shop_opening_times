class ShopController < ApplicationController
  DAY_OF_WEEK = %i[sunday monday tuesday wednesday thursday friday saturday].freeze

  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
    @render_opening_times = init_hash_day_of_week
    @current_day_week = DAY_OF_WEEK[Date.current.wday]

    today = DateTime.current.beginning_of_day
    shop_opening_times = @shop.opening_times.where(end_date: today..today + DAY_OF_WEEK.size) || []

    shop_opening_times.each do |opening_time|
      @render_opening_times[DAY_OF_WEEK[opening_time.start_date.wday]].push(opening_time)
    end
  end

  private

  def init_hash_day_of_week
    {}.tap do |hash|
      DAY_OF_WEEK.rotate(Date.current.wday).each do |day|
        hash[day] = []
      end
    end
  end
end
