require 'test_helper'

class MeasurementTypeTest < ActiveSupport::TestCase
  setup do
    @tracker = create(:tracker)
  end

  test "valid measurement type" do
    measurement_type = MeasurementType.new tracker: @tracker, name: "foo"
    assert measurement_type.valid?
  end

  test "should not save measurement type without name" do
    measurement_type = MeasurementType.new tracker: @tracker
    refute measurement_type.valid?
    assert_not_nil measurement_type.errors[:name]
  end

  test "invalid without user" do
    measurement_type = MeasurementType.new name: "foo"
    refute measurement_type.valid?
    assert_not_nil measurement_type.errors[:tracker]
  end
end
