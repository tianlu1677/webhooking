# frozen_string_literal: true

class DashboardPolicy < ApplicationPolicy
  def show_sidebar?
    true
  end
end
