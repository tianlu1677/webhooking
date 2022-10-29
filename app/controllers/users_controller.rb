# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def webhooks
    @webhooks = current_user.webhooks
  end
end
