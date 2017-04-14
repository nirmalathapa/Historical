class AddMeasurementTypeAndValueToMeasurements < ActiveRecord::Migration[5.0]
  def change
    add_reference :measurements, :measurement_type, foreign_key: true
    add_column :measurements, :value, :decimal
  end
end
