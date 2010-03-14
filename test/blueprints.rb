require 'machinist/active_record'
require 'sham'

Sham.gender(:unique => false) { rand(2) == 0 ? 'M' : 'F' }
Sham.age { |index| index }
Sham.faq_idx { |index| index }
Sham.email { |index| "user#{index}@example.com" }


AgeRange.blueprint do
  low {Sham.age}
  high {Sham.age + 10}
end

Event.blueprint do
  year Date.today.year
  location "Someville, ST"
  hotel "Fawlty Towers"
  registration_cost 100
  registration_count 0
  max_seats 65
  start_date Date.today + 30
  end_date Date.today + 37
end

Faq.blueprint do
  title { "When " + Faker::Lorem.words(4).join(' ') }
  body { Faker::Lorem.words(10).join(' ') }
  list_order { Sham.faq_idx }
  publish true
end

User.blueprint do
  email { Sham.email }
  activated true
  last_visit Date.today - 30
  password "secret"
  admin false
end

Registration.blueprint do
  address1 "123 Street Name"
  city "Cityville"
  state "ST"
  phone "123.123.1234"
  first_name "Fname"
  last_name "Lname"
  user { User.make }
  age_range { AgeRange.make }
  event { Event.make }
  amount_owed 100
  zip_code "12345"
  shirt %w(xxl xl l m s).rand
  gender { Sham.gender }
  mobile "123.123.1234"
end
