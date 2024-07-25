# frozen_string_literal: true

module Admin
  class WebhooksController < Admin::ApplicationController
    before_action :set_webhook, only: %i[show edit update destroy]

    def index
      @q = Webhook.all.ransack(params[:q])
      @webhooks = @q.result.order('webhooks.id desc')
      @pagy, @webhooks = pagy(@webhooks, items: params[:per_page] || 20, page: params[:page])
    end

    def show; end

    def new
      @webhook = Webhook.new
    end

    def edit; end

    def create
      @webhook = Webhook.new(webhooks_params)

      if @webhook.save
        redirect_to(admin_webhooks_path, notice: 'create success')
      else
        render :new
      end
    end

    def update
      if @webhook.update(webhook_params)
        respond_to do |format|
          format.html { redirect_to(admin_webhooks_path, notice: 'Update success') }
          format.js
        end
      else
        render :edit
      end
    end

    def destroy
      @webhook.destroy
      respond_to do |format|
        format.html { redirect_to admin_webhooks_path, notice: 'Delete success' }
        format.js
      end
    end

    private

    def set_webhook
      @webhook = Webhook.find(params[:id])
    end

    def webhook_params
      params.require(:webhook).permit!
    end
  end
end
