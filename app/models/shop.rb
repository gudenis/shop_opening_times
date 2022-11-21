class Shop < ApplicationRecord
  DAY_OF_WEEK = %i[sunday monday tuesday wednesday thursday friday saturday].freeze

  has_many :opening_times, dependent: :delete_all

  validates_associated :opening_times
  validates :name, presence: true, uniqueness: true

  def current_opening_times(day_depth)
    today = DateTime.current.beginning_of_day

    init_hash_day_of_week.tap do |hash_opening_times|
      find_opening_times_with_depth(today, day_depth).each do |opening_time|
        hash_opening_times[DAY_OF_WEEK[opening_time.start_date.wday]].push(opening_time)
      end
    end
  end

  private

  def find_opening_times_with_depth(day, day_depth)
    opening_times.where(end_date: day..day + day_depth) || []
  end

  def init_hash_day_of_week
    {}.tap do |hash|
      DAY_OF_WEEK.rotate(Date.current.wday).each do |day|
        hash[day] = []
      end
    end
  end
end
