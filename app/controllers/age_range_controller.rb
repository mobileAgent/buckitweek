class AgeRangeController < ApplicationController
  before_filter :authorize_admin
  scaffold :age_range
end
