# frozen_string_literal: true

class SpectrumPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    policy(record.measurement).update?
  end

  def destroy?
    policy(record.measurement).destroy?
  end

  def index?
    true
  end

  def show?
    true
  end
end
