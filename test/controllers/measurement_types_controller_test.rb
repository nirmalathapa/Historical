require 'test_helper'

class MeasurementTypesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user)
    @tracker = create(:tracker, user: @user)

    sign_in @user
  end

  test "should get index" do
    get tracker_measurement_types_url( tracker_id: @tracker.id )
    assert_response :success
  end

  test "should get new" do
    get new_tracker_measurement_type_url( tracker_id: @tracker.id )
    assert_response :success
  end

  test "should create measurement_type" do
    assert_difference('MeasurementType.count') do
      post tracker_measurement_types_url(@tracker), params: { measurement_type: { name: "Foo bar" } }
    end

    assert_redirected_to tracker_measurement_types_url(@tracker)
  end

  test "should get edit" do
    @measurement_type = create(:measurement_type)
    get edit_measurement_type_url(@measurement_type)
    assert_response :success
  end

  test "should update measurement_type" do
    @measurement_type = create(:measurement_type)
    patch measurement_type_url(@measurement_type), params: { measurement_type: { name: "test" } }
    assert_redirected_to measurement_type_url(@measurement_type)
  end

  test "should destroy measurement_type" do
    @measurement_type = create(:measurement_type, tracker: @tracker)
    assert_difference('MeasurementType.count', -1) do
      delete measurement_type_url(@measurement_type)
    end

    assert_redirected_to tracker_measurement_types_url(@tracker)
  end
end
