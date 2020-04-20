module MembersHelper
  # Please select user's information from members
  def user_info_from(members)
    @members.map.with_index do |member, ind|
      [member.user.name, ind + 1]
    end
  end
end
