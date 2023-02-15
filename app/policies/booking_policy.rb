class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
    end
  end

  def new?
    # allow if current user is differente from the user who created the astro...
    create?
  end

  def create?
    true
  end

  def destroy
    record.user == user
  end
end
