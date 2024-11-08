class Department < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true
  validates :cover, presence: true

  # ActiveStorage
  has_one_attached :cover

  # Asociations
  has_many :employees, dependent: :nullify
  has_many :feedbacks, as: :feedbackable, dependent: :destroy
end
