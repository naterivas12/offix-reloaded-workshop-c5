class FeedbackPolicy < ApplicationPolicy
  def show?
    @record.feedbackable == @user || @user.reports.include?(@record.feedbackable)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
