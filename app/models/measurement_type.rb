class MeasurementType < ApplicationRecord
  belongs_to :tracker
  has_many :measurements, dependent: :destroy
  validates :name, presence: true
  before_create :set_type_name

  def set_type_name
    self.type_name = name.to_s.parameterize.underscore
  end
end
