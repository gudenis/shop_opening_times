class Shop < ApplicationRecord
  has_many :opening_times, dependent: :delete_all

  validates_associated :opening_times
  validates :name, presence: true, uniqueness: true
end
