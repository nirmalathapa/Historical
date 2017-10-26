class Tracker < ApplicationRecord
  belongs_to :user

  has_many :measurement_types
  validates :name, presence: true
end
