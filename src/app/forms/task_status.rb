class TaskStatus
  include ActiveModel::Model
  attr_accessor :status, :task_id
  
  def update
    task = Task.find(task_id)
    task.status += status.to_i
    !!task.save
  end
end