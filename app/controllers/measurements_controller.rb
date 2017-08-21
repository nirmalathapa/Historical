class MeasurementsController < ApplicationController
  before_action :authenticate_user!

  def new
    @measurement_form = MeasurementForm.new(user: current_user)
    @last_measurements = MeasurementType.all.inject({}) do |data, type|

      current_record, last_record  = Measurement
        .where(user: current_user, measurement_type: type)
        .order(created_at: :desc)
        .limit(2)
        .to_a

      change = current_record&.value.to_f - last_record&.value.to_f

      data[type.name] = { date: last_record&.measurement_date, value: last_record&.value, change: change }
      data
    end
  end

  def create
    @measurement_form = MeasurementForm.new(measurement_params.merge(user: current_user))

    if @measurement_form.save
      redirect_to new_measurement_path, notice: 'Saved'
    else
      render :new
    end
  end

  def show
    @date = parse_date
    @measurements = MeasurementType.all.inject({}) do |data, type|
      value = Measurement
        .find_by(user: current_user, measurement_date: @date, measurement_type: type)
        .try(:value)

      data[type.name] = value
      data
    end
  end

  def index
    @type = MeasurementType.find_by(name: params[:type]) || MeasurementType.last
    @measurements = Measurement
        .where(user: current_user, measurement_type: @type)
        .order(created_at: :desc)
  end

  private

  def measurement_params
    params.require(:measurement_form).permit(
      *(MeasurementForm.measurement_fields + [:date])
    )
  end

  def parse_date
    Date.parse(params[:date])
  rescue
    Date.today
  end
end
