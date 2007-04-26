module ApplicationHelper
  def short_date (time)
    return if time.nil?
    if (time < 2.months.ago)
      time.strftime("%b %d %Y")
    else
      time_ago_in_words(time) + " ago"
    end
  end

  def tight_range (age_range)
     "#{age_range.low}-#{age_range.high}"
  end

end
