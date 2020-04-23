module TasksHelper
  def priority_of(task)
    priorities = ['Low', 'Medium', 'High']
    priorities[task]
  end

  def tags_of(task)
    tags = task.taggings.map { |tagging| tagging.tag }
  end
end
