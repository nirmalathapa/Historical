require 'test_helper'

class MeasurementFormTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @tracker = create(:tracker, user: @user, name: 'test')
    @type = create(:measurement_type, tracker: @tracker, name: 'score')
    @form = MeasurementForm.new(@user, @tracker)
  end

  test "defines readers for fields" do
    assert @form.respond_to?(:score) == true
  end

  test "updates field attributes" do
    form1 = MeasurementForm.new(@user, @tracker, {score: 3})
    assert form1.score == 3
  end

  test "defines writers for fields" do
    assert @form.respond_to?(:score=) == true
  end

  test "allows setting field attributes" do
    @form.score = 1
    assert @form.score == 1
  end

  test "sets default date as today" do
    assert @form.date = Date.today
  end

  test "existing field value" do
    create(:measurement, user: @user, measurement_date: Date.today, measurement_type: @type, value: 19)
    assert @form.score == 19
  end
end
