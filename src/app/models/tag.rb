class Tag < ApplicationRecord
  belongs_to :project
  validates :name, presence: true, length: { maximum: 20 }
end
