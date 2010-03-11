Factory.define :age_range do |a|
  a.sequence(:low) { |n| n }
  a.high { |u| u.low + 20 }
end

Factory.define :event do |e|
  e.year Date.today.year
  e.location "City, State"
  e.registration_cost 100
  e.registration_count 0
  e.max_seats 65
  e.start_date Date.today + 30
  e.end_date { |event| event.start_date + 7 }
end

Factory.define :faq do |f|
  f.title "Faq Title"
  f.body "Faq Answer String"
  f.sequence(:list_order) { |n| n }
  f.publish true
end

Factory.define :user do |u|
  u.sequence(:email) { |n| "user#{n}@example.com" }
  u.activated true
  u.last_visit Date.today - 30
  u.password "secret"
end

Factory.define :registration do |r|
  r.address1 "123 Street Name"
  r.city "Cityville"
  r.state "MD"
  r.phone "123.123.1234"
  r.sequence(:first_name) { |n| "Person#{n}" }
  r.sequence(:last_name) { |n| "Name#{n}" }
  r.association :user
  r.age_range { |a| a.association :age_range }
  r.event { |a| a.association :event }
  r.amount_owed 100
  r.zip_code "12345"
  r.shirt %w(xxl xl l m s).rand
  r.sequence(:gender) { |n| ["M","F"][n%2] }
  r.mobile { |u| u.phone }
end
    
