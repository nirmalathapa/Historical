class AddTrackerToMeasurementType < ActiveRecord::Migration[5.1]
  def change
    add_reference :measurement_types, :tracker, foreign_key: true
  end
end
