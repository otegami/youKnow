class Project < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  validation :user_id, presence: true
end
