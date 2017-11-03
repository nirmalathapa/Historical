require 'test_helper'

class TrackerTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  test "valid tracker" do
    tracker = Tracker.new user: @user, name: "foo"
    assert tracker.valid?
  end

  test "should not save tracker without name" do
    tracker = Tracker.new user: @user
    refute tracker.valid?
    assert_not_nil tracker.errors[:name]
  end

  test "invalid without user" do
    tracker = Tracker.new name: "foo"
    refute tracker.valid?
    assert_not_nil tracker.errors[:user]
  end

  test "deletes dependent measurement types" do
    tracker = create(:tracker)
    create(:measurement_type, tracker: tracker)

    assert_difference('MeasurementType.count', -1) do
      tracker.destroy
    end
  end
end
