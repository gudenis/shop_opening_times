require 'rails_helper'
RSpec.describe ShopController, type: :controller do
  describe "get all shop" do
    it "assigns @shops valid" do
      shop_test = Shop.create(name: 'test')
      shop_another_test = Shop.create(name: 'another_test')
      get :index
      expect(assigns(:shops)).to eq([shop_test, shop_another_test])
    end
  end

  describe "get one shop" do
    it "assigns @shop, @render_opening_times, @current_day_week valid" do
      shop_test = Shop.create(name: 'test')
      today = Date.new(2022, 11, 20)
      opening_times = [OpeningTime.create(shop: shop_test, start_date: today, end_date: today + 2.hours),
                       OpeningTime.create(shop: shop_test, start_date: today + 6.day, end_date: today + 7.day),
                       OpeningTime.create(shop: shop_test, start_date: today + 1.week, end_date: today + 1.week + 2.hours)]
      render_opening_times = {
        monday: [],
        tuesday: [],
        wednesday: [],
        thursday: [],
        friday: [],
        saturday: [],
        sunday: [opening_times[0]],
      }

      get :show, params: { id: shop_test }
      expect(assigns(:shop)).to eq(shop_test)
      expect(assigns(:render_opening_times)).to eq(render_opening_times)
      expect(assigns(:current_day_week)).to eq(:sunday)
    end
  end
end
