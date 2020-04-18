class Task < ApplicationRecord
  include RailsSortable::Model
  set_sortable :sort
  belongs_to :project
  validates :name, presence: true, length: { maximum: 30 }
  validates :deadline, presence: true
  validates :content, presence: true, length: { maximum: 500 }
end
