require 'rails_helper'
RSpec.describe OpeningTime, type: :model do
  let(:shop) { Shop.create!(name: "ShopTest") }

  describe 'valid presence field' do
    it 'should be valid' do
      opening_time = OpeningTime.new(shop: shop, start_date: Time.now, end_date: Time.now + 2.hours)
      expect(opening_time.valid?).to be(true)
    end

    it 'should not be valid, end_date missing' do
      opening_time = OpeningTime.new(shop: shop, end_date: Time.now + 2.hours)
      expect { opening_time.valid? }.to raise_error(NoMethodError) # validate broken
    end

    it 'should not be valid, start_date missing' do
      opening_time = OpeningTime.new(shop: shop, start_date: Time.now)
      expect { opening_time.valid? }.to raise_error(ArgumentError) # validate broken
    end
  end

  describe 'valid overlap' do
    let(:start_date) { Time.new(2022, 11, 18, 9) }
    let(:end_date) { Time.new(2022, 11, 18, 13) }
    before do
      OpeningTime.create!(shop: shop, start_date: start_date, end_date: end_date)
    end

    it 'should not be valid, start date is in another opening time' do
      opening_time = OpeningTime.new(shop: shop, start_date: start_date + 1.hours, end_date: end_date + 1.hours)
      expect(opening_time.valid?).to be(false)
    end

    it 'should not be valid, end date is in another opening time' do
      opening_time = OpeningTime.new(shop: shop, start_date: start_date - 1.hours, end_date: end_date - 1.hours)
      expect(opening_time.valid?).to be(false)
    end

    it 'should not be valid, end/start date is in inside another opening time' do
      opening_time = OpeningTime.new(shop: shop, start_date: start_date + 1.hours, end_date: end_date - 1.hours)
      expect(opening_time.valid?).to be(false)
    end

    it 'should not be valid, this opening time take in another opening time' do
      opening_time = OpeningTime.new(shop: shop, start_date: start_date - 1.hours, end_date: end_date + 1.hours)
      expect(opening_time.valid?).to be(false)
    end

    it 'should not be valid, start_date is the same as another end_date' do
      opening_time = OpeningTime.new(shop: shop, start_date: end_date, end_date: end_date + 1.hours)
      expect(opening_time.valid?).to be(false)
    end

    it 'should not be valid, start_date is the same as another end_date' do
      opening_time = OpeningTime.new(shop: shop, start_date: start_date - 3.hours, end_date: start_date)
      expect(opening_time.valid?).to be(false)
    end

    it 'should be valid' do
      opening_time = OpeningTime.new(shop: shop, start_date: start_date - 3.hours, end_date: start_date - 1.hours)
      expect(opening_time.valid?).to be(true)
    end
  end

  describe 'valid hours' do
    let(:start_date) { Time.new(2022, 11, 18, 9) }
    let(:end_date) { Time.new(2022, 11, 18, 13) }

    it 'should not be valid, end date before start_date' do
      opening_time = OpeningTime.new(shop: shop, start_date: end_date, end_date: start_date)
      expect(opening_time.valid?).to be(false)
    end

    it 'should not be valid, end date and start_date start at the same minute' do
      opening_time = OpeningTime.new(shop: shop, start_date: start_date, end_date: start_date + 30.second)
      expect(opening_time.valid?).to be(false)
    end

    it 'should not be valid, end date and start_date are not same day' do
      opening_time = OpeningTime.new(shop: shop, start_date: start_date, end_date: start_date + 1.day)
      expect(opening_time.valid?).to be(false)
    end

    it 'should be valid' do
      opening_time = OpeningTime.new(shop: shop, start_date: start_date, end_date: start_date + 30.second)
      expect(opening_time.valid?).to be(false)
    end
  end
end
