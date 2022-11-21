class ShopController < ApplicationController
  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
    @render_opening_times = @shop.current_opening_times(Shop::DAY_OF_WEEK.size)
    @current_day_week = Shop::DAY_OF_WEEK[Date.current.wday]
  end
end
