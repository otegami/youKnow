module ProjectsHelper
  def owner?(project)
    current_user.members.find_by('project_id = ?', project.id).owner
  end
end
