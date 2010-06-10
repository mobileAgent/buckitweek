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

  def start_day_of_week
    start_date.strftime("%A")
  end

  def end_day_of_week
    end_date.strftime("%A")
  end

  # format whole range
  def event_date_string
    "#{start_text}-#{end_text}, #{end_date.year}"
  end

  def hotel_confirmed?
    return hotel && hotel.length > 0 && hotel.index(/TBD/).nil?
  end
  
  # Scale the registration cost by how many
  # times the user has attended before
  def registration_cost_scale(num_times_attended)
    registration_cost
  end

  def topic_list
    topics.split /;/
  end

  def speakers
    s = [speaker_one, speaker_two]
    s << speaker_three unless (speaker_three.nil? || speaker_three.blank?)
    s
  end
  
end
