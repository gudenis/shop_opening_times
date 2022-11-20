module ShopHelper
  def format_opening_time(opening_times)
    result = ""
    opening_times.each do |opening_time|
      result.concat(format_date(opening_time.start_date,"%H:%M"))
            .concat('-')
            .concat(format_date(opening_time.end_date,"%H:%M"))

      result.concat(', ') unless opening_times.last == opening_time
    end

    result
  end
end
