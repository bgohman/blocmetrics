class RegisteredApplicationPolicy < ApplicationPolicy
  def index?
    user.present? && (record.user == user)
  end

  def show?
    user.present? && (record.user == user)
  end

end