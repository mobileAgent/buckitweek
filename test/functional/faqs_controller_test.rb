require 'test_helper'

class FaqsControllerTest < ActionController::TestCase
  
  test "get faqs index" do
    get :index
    assert_response :success
  end

  test "get show of a faq item" do
    @f = Faq.make
    get :show, :id => @f.id.to_param
    assert_response :success
  end
  
end
