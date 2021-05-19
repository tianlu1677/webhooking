# frozen_string_literal: true

class Admin::WebhooksController < Admin::ApplicationController
  before_action :set_webhook, only: %i[show edit update destroy]

  def index
    @q = Webhook.all.ransack(params[:q])
    @webhooks = @q.result.order('webhooks.id desc')#.page(params[:page] || 1).per(params[:per] || 10)
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
      redirect_to(admin_webhooks_path, notice: '创建成功。')
    else
      render :new
    end
  end

  def update
    if @webhook.update(webhook_params)
      respond_to do |format|
        format.html { redirect_to(admin_webhooks_path, notice: '更新成功。') }
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @webhook.destroy
    respond_to do |format|
      format.html { redirect_to admin_webhooks_path, notice: '删除成功.' }
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
