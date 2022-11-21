require 'rails_helper'
RSpec.describe ApplicationHelper do
  class ApplicationHelperUT
    include ApplicationHelper
  end

  let(:subject) { ApplicationHelperUT.new }
  describe ' format_date tests' do
    let(:date) { Time.new(2022, 11, 21, 9, 0, 0) }

    it 'return hours pattern' do
      expect(subject.format_date(date, "%H:%M")).to eq("09:00")
    end

    it 'invalid pattern' do
      expect(subject.format_date(date, "invalid")).to eq("invalid")
    end
  end
end