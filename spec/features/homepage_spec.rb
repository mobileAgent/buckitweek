require 'rails_helper'

# This spec exists primarily to lock in two things that have already broken
# once during the migration:
#   1. ApplicationController's before_filter that calls Event.last
#      (the Arel/Integer/Fixnum patch keeps this working on Ruby 2.6+)
#   2. The full Rails 3.2 boot + render cycle in the test environment
# When either breaks during a Rails version bump, this spec will fail loud.

feature 'Homepage' do
  scenario 'renders successfully with an event in the database' do
    create(:event)
    visit '/'
    expect(page.status_code).to eq(200)
  end

  scenario 'renders successfully even with no events' do
    visit '/'
    expect(page.status_code).to eq(200)
  end
end
