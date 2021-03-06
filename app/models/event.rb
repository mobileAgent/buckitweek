class Event < ActiveRecord::Base
  has_many :registrations

  attr_accessible :location, :start_date, :end_date,:speaker_one,:speaker_two,:speaker_three,:registration_count,:registration_cost,:max_seats,:topics,:hotel,:year,:registration_open
  
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

  def full_location
    if hotel_confirmed?
      "#{hotel}, #{location}"
    else
      location
    end
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
    s = [speaker_one]
    s << speaker_two unless (speaker_two.nil? || speaker_two.blank?)
    s << speaker_three unless (speaker_three.nil? || speaker_three.blank?)
    s
  end
  
end
