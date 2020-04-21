class Tag < ApplicationRecord
  belongs_to :project
  has_many :taggings
  has_many :tasks, through: :taggings
  validates :name, presence: true, length: { maximum: 20 }
end
