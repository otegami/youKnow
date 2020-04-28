class TaskForm
  include ActiveModel::Model
  attr_accessor :name, :deadline, :content, :priority, :project_id, :current_user

  validates :name, presence: true, length: { maximum: 30 }
  validates :deadline, presence: true
  validates :content, presence: true, length: { maximum: 500 }
  validates :priority, presence: true, numericality: { less_than_or_equal_to: 2 }

  concerning :TaskBuilder do
    def task
      @task ||= Project.find(project_id).tasks.build
    end
  end

  concerning :PicBuilder do
    attr_accessor :pic_attributes
    
    def pic_attributes=(attributes)
      @pic_attributes = Pic.new(attributes)
    end

    def pic
      @pic_attributes ||= Pic.new
    end

    def owner_pic
      Pic.new(user_id: current_user.id, owner: true)
    end

    def pic_user(task_attributes)
      pic_user = task_attributes.pics.find_by(owner: false )
      if pic_user
        { "user_id" => pic_user.id }
      else
        pic_owner = task_attributes.pics.find_by(owner: true )
        { "user_id" => pic_owner.id }
      end
    end
  end

  concerning :TagsBuilder do
    attr_accessor :taggings_attributes

    def taggings
      @taggings_attributes ||= Tagging.new
    end
    
    def taggings_attributes=(attributes)
      @taggings_attributes = []
      attributes["tag_id"].each do |id|
        @taggings_attributes << Tagging.new(tag_id: id)
      end
    end

    def tags_id(task_attributes)
      task_attributes.tags.each do |tagging|
        form.taggings_attributes << tagging.tag_id.to_s  
      end
    end
  end

  class << self
    def find(id)
      task_attributes = Task.find(id)
      @task_form = TaskForm.new(
        name: task_attributes.name,
        deadline: task_attributes.deadline,
        content: task_attributes.content,
        priority: task_attributes.priority,
        pic_attributes: {
          user_id: pic_user(task_attributes)
        },
        taggings_attributes: {
          tag_id: tags_id(task_attributes)
        }
      )
    end
  end
  
  def save
    return false if invalid?

    task.assign_attributes(task_params)
    build_asscociations_with_tagging
    build_asscociations_with_pic
    
    if task.save
      true
    else
      false
    end
  end

  private
  def task_params
    {
      name: name,
      deadline: deadline,
      content: content,
      priority: priority
    }
  end

  def build_asscociations_with_tagging
    task.taggings << taggings
  end

  def build_asscociations_with_pic
    # Check whether pic user is themselves
    task.pics << pic unless pic.user_id == current_user.id
    task.pics << owner_pic
  end
end