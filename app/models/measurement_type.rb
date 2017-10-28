class MeasurementType < ApplicationRecord
  belongs_to :tracker

  validates :name, presence: true
end
