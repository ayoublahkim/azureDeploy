# frozen_string_literal: true

require_relative "vcr"

module GitHubFactory
  def classroom_student
    return @classroom_student if defined?(@classroom_student)
    @classroom_student = create(:user,
      uid: classroom_student_github_id,
      token: classroom_student_github_token,
      github_global_relay_id: global_relay_id_from_id(classroom_student_github_id))
  end

  def classroom_teacher
    return @teacher if defined?(@teacher)
    @teacher = create(:user,
      uid: classroom_owner_github_id,
      token: classroom_owner_github_token,
      github_global_relay_id: global_relay_id_from_id(classroom_owner_github_id))
  end

  def classroom_org
    return @classroom_org if defined?(@classroom_org)

    options = {
      title: classroom_owner_organization_github_login,
      github_id: classroom_owner_organization_github_id,
      users: [classroom_teacher]
    }

    @classroom_org = create(:organization, options)
  end

  def global_relay_id_from_id(id)
    Base64.strict_encode64(["04:User", id.to_s].join)
  end
end
