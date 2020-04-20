module MembersHelper
  # Please select user's information from members
  def user_info_from(members)
    @members.map do |member|
      [member.user.name, member.user.id]
    end
  end
end
