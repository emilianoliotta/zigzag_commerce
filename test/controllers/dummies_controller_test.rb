require 'test_helper'

class DummiesControllerTest < ActionController::TestCase
  test "should get on_success" do
    get :on_success
    assert_response :success
  end

  test "should get on_failure" do
    get :on_failure
    assert_response :success
  end

  test "should get on_pending" do
    get :on_pending
    assert_response :success
  end

end
