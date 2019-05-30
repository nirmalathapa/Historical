class MeasurementsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_default_tracker, only: :new

  def new
    @measurement_form = MeasurementForm.new(current_user, tracker)
    @last_measurements = measurement_types.inject({}) do |data, type|

      current_record, last_record  = Measurement
        .where(user: current_user, measurement_type: type)
        .order(measurement_date: :desc)
        .limit(2)
        .to_a

      change = current_record&.value.to_f - last_record&.value.to_f

      data[type.type_name] = { date: last_record&.measurement_date, value: last_record&.value, change: change }
      data
    end
  end

  def create
    @measurement_form = MeasurementForm.new(current_user, tracker, measurement_params)

    if @measurement_form.save
      redirect_to new_measurement_path(tracker_id: tracker.id), notice: 'Saved'
    else
      render :new
    end
  end

  def show
    @date = parse_date
    @measurements = measurement_types.all.inject({}) do |data, type|
      value = Measurement
        .find_by(user: current_user, measurement_date: @date, measurement_type: type)
        .try(:value)

      data[type.type_name] = value
      data
    end
  end

  def index
    @type = MeasurementType.find_by(name: params[:type]) || MeasurementType.last
    @measurements = Measurement
        .where(user: current_user, measurement_type: @type)
        .order(measurement_date: :desc)
  end

  private

  def measurement_params
    params.require(:measurement_form).permit(
      *(MeasurementForm.new(current_user, tracker).measurement_fields + [:date])
    )
  end

  def measurement_types
    tracker.measurement_types
  end

  def tracker
    @tracker ||=
      current_user.trackers.find_by(id: params[:tracker_id]) || current_user.trackers.first
  end

  def check_default_tracker
    return redirect_to new_tracker_path unless tracker
  end

  def parse_date
    Date.parse(params[:date])
  rescue
    Date.today
  end
end
