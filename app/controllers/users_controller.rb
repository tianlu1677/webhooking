# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def webhooks
    @webhooks = current_user.webhooks
  end
end
