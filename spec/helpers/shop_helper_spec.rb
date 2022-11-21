require 'rails_helper'
RSpec.describe ShopHelper do
  class ShopHelperUT
    include ApplicationHelper
    include ShopHelper
  end

  let(:start_date) { Time.new(2022, 11, 21, 9, 0, 0) }
  let(:end_date) { Time.new(2022, 11, 21, 11, 0, 0) }
  let(:subject) { ShopHelperUT.new }
  let(:opening_time) { [OpeningTime.new(start_date: start_date, end_date: end_date)] }
  let(:opening_times) { [OpeningTime.new(start_date: start_date, end_date: end_date),
                         OpeningTime.new(start_date: start_date, end_date: end_date)] }

  describe 'format opening time' do

    it 'return format with one opening time' do
      expect(subject.format_opening_time(opening_time)).to eq("08:00-10:00")
    end

    it 'return format with many opening times' do
      expect(subject.format_opening_time(opening_times)).to eq("08:00-10:00, 08:00-10:00")
    end
  end
end