class TaskForm
  include ActiveModel::Model
  attr_accessor :name, :deadline, :content, :priority, :project_id

  concerning :TaskBuilder do
    def task
      @task ||= Project.find(project_id).tasks.build
    end
  end

  concerning :PicBuilder do
    attr_reader :pic_attributes
    
    def pic
      @pic_attributes ||= Pic.new
    end

    def pic_attributes=(attributes)
      @pic_attributes = Pic.new(attributes)
    end
  end

  def save
    return false if invalid?

    task.assign_attributes(task_params)
    build_asscociations

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
    task.pics << pic
  end
end