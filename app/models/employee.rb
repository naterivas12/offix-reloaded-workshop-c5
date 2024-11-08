class Employee < ApplicationRecord
  attr_accessor :skip_password_validation

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :name, :position, :avatar, presence: true

  # Associations
  belongs_to :department, counter_cache: true

  has_many :reports, class_name: "Employee",
                     foreign_key: "manager_id",
                     dependent: :nullify,
                     inverse_of: "manager"

  belongs_to :manager, class_name: "Employee",
                       optional: true

  has_many :feedbacks, dependent: :destroy # autor de muchos feedbacks
  has_many :feedbacks, as: :feedbackable, dependent: :destroy # receptor de muchos feedback

  # ActiveStorage
  has_one_attached :avatar

  # Enumerators
  enum :role, { admin: 1, contributor: 0 }

  private

  def password_required?
    return false if skip_password_validation

    super
  end
end
