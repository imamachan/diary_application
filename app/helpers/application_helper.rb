module ApplicationHelper
  include SimpleCalendar::CalendarHelper
  def page_title(title = "")
    base_title = "HiBiLog"
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
