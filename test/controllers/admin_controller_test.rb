require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  test "should get index" do
    get admin_url
    assert_response :success
  end
end
