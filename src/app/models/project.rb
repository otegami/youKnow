class Project < ApplicationRecord
  has_many :members
	has_many :users, through: :members
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 150 }

  # Close project with changeing status from open to close
  def closed
    update_attribute(:status, false)
  end
end
