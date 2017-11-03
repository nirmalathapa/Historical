class Tracker < ApplicationRecord
  belongs_to :user

  has_many :measurement_types, dependent: :destroy
  validates :name, presence: true
end
