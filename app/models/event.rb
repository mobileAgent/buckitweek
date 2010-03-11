class Event < ActiveRecord::Base
  has_many :registrations
  
  # microformat support
  def start_cal
    start_date.to_s(:dcal)
  end

  # microformat support (needs +1 day)
  def end_cal
    end_date.tomorrow.to_s(:dcal)
  end

  # format for home page month, day
  def start_text
    start_date.strftime("%B %e")
  end
  
  # format for home page month, day
  def end_text
    if (end_date.mon == start_date.mon)
      end_date.strftime("%e")
    else
      end_date.strftime("%B %e")
    end
  end

  # format whole range
  def event_date_string
    "#{start_text}-#{end_text}, #{end_date.year}"
  end
  
end
