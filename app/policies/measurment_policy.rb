# frozen_string_literal: true

class MeasurmentPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    user.has_role?(:admin) || user.author?(record)
  end

  def destroy?
    user.has_role?(:admin) || user.author?(record)
  end

  def index?
    true
  end

  def show?
    true
  end
end
