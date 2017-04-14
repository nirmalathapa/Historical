class CreateMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :measurements do |t|
      t.belongs_to :user
      t.date :measurement_date

      t.timestamps
    end
  end
end
