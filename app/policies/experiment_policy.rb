# frozen_string_literal: true

class ExperimentPolicy < ApplicationPolicy
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

  def favorite?
    true
  end
end
