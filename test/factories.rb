FactoryGirl.define do
  

  factory :age_range do
    low 17
    high 23
  end

  factory :event do
    year Date.today.year
    location "Someville, ST"
    hotel "Fawlty Towers"
    speaker_one "Fred Flintstone"
    speaker_two "Barney Rubble"
    topics "Church Truth; Lost Cities; Eternal Life; More Stuff"
    registration_cost 100
    registration_count 0
    max_seats 65
    start_date Date.today + 30
    end_date Date.today + 37
    registration_open true
  end

  factory :faq do
    title "Lorem ipsum dolor sit" 
    body "Lorem blah blah blah ipsum blah blah blah dolor blah blah bla sit."
    list_order 1
    publish true
  end

  factory :user do
    sequence :email do |n|
      "user#{n*2}@example.com"
    end
    activated true
    last_visit Date.today - 30
    password "secret"
    admin false
  end

  factory :registration do
    address1 "123 Street Name"
    city "Cityville"
    state "ST"
    phone "123.123.1234"
    first_name "Fname"
    last_name "Lname"
    user FactoryGirl.create(:user)
    age_range FactoryGirl.create(:age_range)
    event FactoryGirl.create(:event)
    amount_owed 100
    zip_code "12345"
    shirt %w(xxl xl l m s).sample
    gender %w(M F).sample
    mobile "123.123.1234"
  end
end
