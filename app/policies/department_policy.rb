class DepartmentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    @user.admin?
  end

  def edit?
    update?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
