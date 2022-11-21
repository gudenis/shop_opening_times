require 'rails_helper'
RSpec.describe ShopController, type: :controller do
  describe "get all shop" do
    it "assigns @shops valid" do
      shop_test = Shop.create(name: 'one_test')
      shop_another_test = Shop.create(name: 'another_test')
      get :index
      expect(assigns(:shops)).to eq([shop_test, shop_another_test])
    end
  end

  describe "get one shop" do
    it "assigns @shop, @render_opening_times, @current_day_week valid" do
      shop_test = Shop.create!(name: 'test')

      get :show, params: { id: shop_test }
      expect(assigns(:shop)).to eq(shop_test)
      expect(assigns(:render_opening_times)).to eq({friday:[], monday:[], saturday:[], sunday:[], thursday:[], tuesday:[], wednesday:[]})
      expect(assigns(:current_day_week)).to eq(Shop::DAY_OF_WEEK[Date.current.wday])
    end
  end
end
