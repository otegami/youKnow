class Task < ApplicationRecord
  include RailsSortable::Model
  set_sortable :sort
  belongs_to :project
  has_many :pics
  has_many :taggings
  has_many :users, through: :pics
  has_many :tags, through: :taggings
  validates :name, presence: true, length: { maximum: 30 }
  validates :deadline, presence: true
  validates :content, presence: true, length: { maximum: 500 }
  validates :priority, presence: true, numericality: { less_than_or_equal_to: 2 }

  def pic_user
    pic = self.pics.find_by(owner: false) || self.pics.find_by(owner: true)
  end

  def pic_owner
    pic = self.pics.find_by(owner: true)
  end

  def tags_id
    if self.tags
      self.taggings.map.with_object([]) do |tagging, tags_id|
        tags_id << tagging.tag_id.to_s
      end
    end
  end
end
