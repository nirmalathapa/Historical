class AddTypeNameToMeasurementType < ActiveRecord::Migration[5.2]
  def change
    add_column :measurement_types, :type_name, :string
  end
end
