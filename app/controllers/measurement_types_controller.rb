class MeasurementTypesController < ApplicationController
  before_action :set_measurement_type, only: [:show, :edit, :update, :destroy]
  before_action :set_tracker, only: [:new, :index, :create]

  # GET /measurement_types
  def index
    @measurement_types = @tracker.measurement_types
  end

  # GET /measurement_types/new
  def new
    @measurement_type = MeasurementType.new
  end

  # GET /measurement_types/1/edit
  def edit
  end

  # POST /measurement_types
  def create
    @measurement_type = @tracker.measurement_types.new(measurement_type_params)

    if @measurement_type.save
      redirect_to tracker_measurement_types_url(@tracker), notice: 'Measurement type was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /measurement_types/1
  def update
    if @measurement_type.update(measurement_type_params)
      redirect_to @measurement_type, notice: 'Measurement type was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /measurement_types/1
  def destroy
    tracker = @measurement_type.tracker
    @measurement_type.destroy
    redirect_to tracker_measurement_types_url(tracker), notice: 'Measurement type was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_measurement_type
      @measurement_type = MeasurementType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def measurement_type_params
      params.require(:measurement_type).permit(:name)
    end

    def set_tracker
      @tracker = current_user.trackers.find(params[:tracker_id])
    end
end
