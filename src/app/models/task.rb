class Task < ApplicationRecord
  include RailsSortable::Model
  set_sortable :sort
  belongs_to :project
  has_many :pics
  has_many :users, through: :pics
  validates :name, presence: true, length: { maximum: 30 }
  validates :deadline, presence: true
  validates :content, presence: true, length: { maximum: 500 }
  validates :priority, presence: true, numericality: { less_than_or_equal_to: 2 }
end
