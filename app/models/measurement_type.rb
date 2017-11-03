class MeasurementType < ApplicationRecord
  belongs_to :tracker
  has_many :measurements, dependent: :destroy
  validates :name, presence: true
end
