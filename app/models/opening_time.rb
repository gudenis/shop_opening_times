class OpeningTime < ApplicationRecord
  belongs_to :shop

  validates :start_date, :end_date, presence: true
  validate :validate_overlap, :validate_hours

  def validate_overlap
    already_opening_time = OpeningTime.where(shop_id: shop.id).and(
      OpeningTime.where(start_date: start_date..end_date)
        .or(OpeningTime.where(end_date: start_date..end_date))
        .or(
          OpeningTime.where(start_date: ..start_date)
                     .and(OpeningTime.where(end_date: end_date..))
        )
    )
    return if already_opening_time.empty?

    errors.add(:overlap, "There are an overlapping with other opening times")
  end

  def validate_hours
    valid_order_hours = start_date < end_date
    valid_duration = end_date - start_date > 1.minute
    valid_day = start_date.wday == end_date.wday

    return if valid_day && valid_duration && valid_order_hours

    errors.add(:date, "Wrong start or end date, must be the same day, (start date < end date)  and have 1 min duration")
  end
end
