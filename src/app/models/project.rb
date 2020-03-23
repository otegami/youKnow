class Project < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 150 }
end
