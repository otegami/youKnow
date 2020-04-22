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
    attr_reader :pic_attributes
    
    def pic_attributes=(attributes)
      @pic_attributes = Pic.new(attributes)
    end

    def pic
      @pic_attributes ||= Pic.new
    end

    def owner_pic
      Pic.new(user_id: current_user.id, owner: true)
    end
  end

  def save
    return false if invalid?

    task.assign_attributes(task_params)
    build_asscociations

    binding.pry
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

  def build_asscociations
    task.pics << pic unless pic.user_id == current_user.id
    task.pics << owner_pic
  end
end