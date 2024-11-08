class Feedback < ApplicationRecord
  # Validations
  validates :content, presence: true

  # Association
  belongs_to :employee
  belongs_to :feedbackable, polymorphic: true
end
