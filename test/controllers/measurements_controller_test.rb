require 'test_helper'

class MeasurementsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user)
    sign_in @user
  end

  test "redirects to new tracker page with no tracker" do
    get new_measurement_path
    assert_response :redirect
    assert_redirected_to new_tracker_path
  end

  test "page success with default tracker" do
    create(:tracker, user: @user)
    get new_measurement_path
    assert_response :success
  end
end
