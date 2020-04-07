class Member < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :owner, inclusion: { in: [true, false] }
end
