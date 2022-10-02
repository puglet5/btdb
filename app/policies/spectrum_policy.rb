# frozen_string_literal: true

class SpectrumPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    policy(record.measurment).update?
  end

  def destroy?
    policy(record.measurment).destroy?
  end

  def index?
    true
  end

  def show?
    true
  end
end
