class TaskForm
  include ActiveModel::Model
  attr_accessor :name, :deadline, :content, :priority, :project_id, :current_user, :task_attributes 

  validates :name, presence: true, length: { maximum: 30 }
  validates :deadline, presence: true
  validates :content, presence: true, length: { maximum: 500 }
  validates :priority, presence: true, numericality: { less_than_or_equal_to: 2 }

  concerning :TaskBuilder do
    def task
      @task ||= Project.find(project_id).tasks.build
    end

    def task(id)
      @task = Task.find(id)
    end
  end

  concerning :PicBuilder do
    attr_reader :pic_attributes

    def pic_attributes=(attributes)
      if task_attributes.nil?
        @pic_attributes = Pic.new(attributes)
      else
        @pic_attributes = attributes.pic_user
      end
    end

    def pic
      @pic_attributes ||= Pic.new
    end

    def owner_pic
      Pic.new(user_id: current_user.id, owner: true)
    end

    def owner_pic?(pic)
      pic.user_id == task.pics.user_id
    end
  end

  concerning :TagsBuilder do
    attr_reader :taggings_attributes

    def taggings
      @taggings_attributes ||= Task.new
    end
    
    def taggings_attributes=(attributes)
      if task_attributes.nil?
        @taggings_attributes = []
        attributes["tag_ids"].each do |id|
          @taggings_attributes << Tagging.new(tag_id: id)
        end
      else
        @taggings_attributes = attributes
        # @taggings_attributes = []
        # attributes.taggings.each do |tagging|
        #   @taggings_attributes << tagging
        # end
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
        task_attributes: task_attributes,
        pic_attributes: task_attributes,
        taggings_attributes: task_attributes
      )
    end
  end

  def persisted?
    task_attributes.nil? ? false : true
  end
  
  def save
    return false if invalid?

    task.assign_attributes(task_params)
    build_associations_with_tagging
    build_associations_with_pic
    
    if task.save
      true
    else
      false
    end
  end

  def update(id)
    return false if invalid?
    task(id)
    update_associations_with_tagging
    update_associations_with_pic

    task_attributes.update_attributes(task_params)
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

  def build_associations_with_tagging
    task.taggings << taggings
  end

  def build_associations_with_pic
    # Check whether pic user is themselves
    task.pics << pic unless pic.user_id == current_user.id
    task.pics << owner_pic
  end

  def update_associations_with_tagging
    task.taggings each do |tagging|
      tagging.destroy
    end
    task.taggings << taggings
  end

  def update_associations_with_pic
    task.pics each do |pic|
      pic.destroy unless pic.owner
    end
    task.pics << pic unless owner_pic?(pic)
  end
end