class PostPolicy < ApplicationPolicy

  def destroy?
    can_moderate?(user, record)
  end

end
