module ApplicationHelper
  def format_date(date, pattern)
    date.strftime(pattern)
  end
end
