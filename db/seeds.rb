shop = Shop.find_or_create_by(name: "AwesomeNameShop")
_shop_closed = Shop.find_or_create_by(name: "ShopClosedAllTime")
shop_saturday = Shop.find_or_create_by(name: "ShopOpenSaturday")
nb_day = 365
today = Date.current.beginning_of_day
(0..nb_day).each do |offset_day|
  current_day = today + offset_day.day
  next if current_day.wday == 0 # Sunday it's closed

  if current_day.wday == 6 #Saturday it's full day
    OpeningTime.create!(shop: shop, start_date: current_day + 10.hours, end_date: current_day + 20.hours)
    OpeningTime.create!(shop: shop_saturday, start_date: current_day + 10.hours, end_date: current_day + 20.hours)
  else
    OpeningTime.create!(shop: shop, start_date: current_day + 10.hours, end_date: current_day + 13.hours)
    OpeningTime.create!(shop: shop, start_date: current_day + 15.hours, end_date: current_day + 20.hours)
  end
end
