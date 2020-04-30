module TasksHelper
  def priority_of(task)
    priorities = ['Low', 'Medium', 'High']
    priorities[task]
  end

  def tags_of(task)
    tags = task.taggings.map { |tagging| tagging.tag }
  end

  def pic_user?(task)
    task.pics.any?{ |pic| pic.user == current_user }
  end
  
  def pic_user(task)
    pic = task.pics.find_by(owner: false) || task.pics.find_by(owner: true)
    pic.user
  end
end
