require 'rails_helper'
RSpec.describe Shop, type: :model do

  describe 'validate field presence ' do
    it 'should be valid' do
      shop = Shop.new(name:'test')
      expect(shop.valid?).to be(true)
    end

    it 'should not be valid, duplicate name' do
      Shop.create!(name: 'test')
      shop = Shop.new(name: 'test')
      expect(shop.valid?).to be(false)
    end

    it 'should not be valid, missing name' do
      shop = Shop.new
      expect(shop.valid?).to be(false)
    end
  end
end