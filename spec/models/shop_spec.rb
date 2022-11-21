require 'rails_helper'
RSpec.describe Shop, type: :model do
  after do
    Shop.delete_all
  end

  describe 'validate field presence ' do
    it 'should be valid' do
      shop = Shop.new(name:'test_valid')
      expect(shop.valid?).to be(true)
    end

    it 'should not be valid, duplicate name' do
      Shop.create!(name: 'test_duplicate')
      shop = Shop.new(name: 'test_duplicate')
      expect(shop.valid?).to be(false)
    end

    it 'should not be valid, missing name' do
      shop = Shop.new
      expect(shop.valid?).to be(false)
    end
  end

  describe 'current_opening_times on shop' do
    it 'return current opening times' do
      shop_test = Shop.create!(name: 'test_current')
      today = DateTime.current.beginning_of_day
      opening_times = [OpeningTime.create(shop: shop_test, start_date: today, end_date: today + 2.hours),
                       OpeningTime.create(shop: shop_test, start_date: today + 6.day, end_date: today + 7.day),
                       OpeningTime.create(shop: shop_test, start_date: today + 1.week, end_date: today + 1.week + 2.hours)]
      current_opening_times = {
        monday: [],
        tuesday: [],
        wednesday: [],
        thursday: [],
        friday: [],
        saturday: [],
        sunday: [],
      }
      current_opening_times[Shop::DAY_OF_WEEK[today.wday]].push(opening_times[0])

      expect(shop_test.current_opening_times(7)).to eq(current_opening_times)
    end
  end
end