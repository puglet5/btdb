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

  def request_processing?
    user.has_role?(:admin) || user.author?(record.measurement)
  end

  def index?
    true
  end

  def show?
    true
  end

  def show_chart_area?
    true
  end

  def show_request_processing_button?
    true
  end

  def show_processing_indicator?
    true
  end
end
