require 'test_helper'

class FaqsControllerTest < ActionController::TestCase
  
  test "get faqs index" do
    get :index
    assert_response :success
  end

  test "get show of a faq item" do
    @f = FactoryGirl.create(:faq)
    get :show, :id => @f.id
    assert_response :success
  end
  
end
