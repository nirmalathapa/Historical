class MeasurementsController < ApplicationController
  before_action :authenticate_user!

  def new
    @measurement_form = MeasurementForm.new(user: current_user)
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
  end

  private

  def measurement_params
    params.require(:measurement_form).permit(
      *(MeasurementForm.measurement_fields + [:date])
    )
  end
end
