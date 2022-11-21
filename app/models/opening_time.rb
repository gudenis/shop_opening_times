class OpeningTime < ApplicationRecord
  belongs_to :shop

  validates :start_date, :end_date, presence: true
  validate :validate_overlap_include, :validate_overlap_cross,
           :validate_chronology_date, :validate_duration, :validate_day

  def validate_overlap_include
    already_opening_time = OpeningTime.where(shop_id: shop.id, start_date: ..start_date)
                                      .and(OpeningTime.where(shop_id: shop.id, end_date: end_date..))

    return if already_opening_time.empty?

    errors.add(:overlap_include, "There are an overlapping with other opening times (include another opening times)")
  end

  def validate_overlap_cross
    already_opening_time = OpeningTime.where(shop_id: shop.id, start_date: start_date..end_date)
                                      .or(OpeningTime.where(shop_id: shop.id, end_date: start_date..end_date))

    return if already_opening_time.empty?

    errors.add(:overlap_cross, "There are an overlapping with other opening times (across with another times)")
  end

  def validate_chronology_date
    return if start_date < end_date

    errors.add(:date_chronloogy, "Wrong start or end date star_date must be before end date, must be the same day, ")
  end

  def validate_duration
    return if end_date - start_date >= 1.minute

    errors.add(:date_duration, "Wrong start or end date, the duration must be at least 1 min")
  end

  def validate_day
    return if start_date.wday == end_date.wday

    errors.add(:date_duration, "Wrong start or end date, these date must be the same day")
  end
end
