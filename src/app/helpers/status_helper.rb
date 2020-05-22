module StatusHelper
  def status_done?(task)
    task.status == 2
  end

  def button_status(task)
    status = ['Start', 'Done']
    status[task.status]
  end
end
