module ProjectsHelper
  def owner?(project)
    p current_user.members.where(project_id: project.id, owner: true)
  end
end
