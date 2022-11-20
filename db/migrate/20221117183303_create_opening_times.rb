class CreateOpeningTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :opening_times do |t|
      t.belongs_to :shop
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
