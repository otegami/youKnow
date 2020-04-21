class Pic < ApplicationRecord
  belongs_to :user
  belongs_to :task
  validates :owner, inclusion: { in: [true, false] }
end
