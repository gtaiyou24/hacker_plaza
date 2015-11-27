require 'test_helper'

class Hacker::ResponsesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
