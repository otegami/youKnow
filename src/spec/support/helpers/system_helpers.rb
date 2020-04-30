module SystemHelpers
  def log_in_as(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  def priority_of(task)
    priorities = ['Low', 'Medium', 'High']
    priorities[task]
  end

  def pic_user(task)
    pic = task.pics.find_by(owner: false) || task.pics.find_by(owner: true)
    pic.user
  end
end