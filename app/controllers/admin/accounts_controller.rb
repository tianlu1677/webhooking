# frozen_string_literal: true

module Admin
  class AccountsController < Admin::ApplicationController
    before_action :set_account, only: %i[show edit update destroy]

    def index
      @q = Account.all.ransack(params[:q])
      @accounts = @q.result.order('accounts.id desc') # .page(params[:page] || 1).per(params[:per] || 10)
      @pagy, @accounts = pagy(@accounts, items: params[:per_page] || 2, page: params[:page])
    end

    def show; end

    def new
      @account = Account.new
    end

    def edit; end

    def create
      @account = Account.new(account_params)

      if @account.save
        redirect_to(admin_accounts_path, notice: '创建成功。')
      else
        render :new
      end
    end

    def update
      if @account.update(account_params)
        respond_to do |format|
          format.html { redirect_to(admin_accounts_path, notice: '更新成功。') }
          format.js
        end
      else
        render :edit
      end
    end

    def destroy
      @account.destroy
      respond_to do |format|
        format.html { redirect_to admin_accounts_path, notice: '删除成功.' }
        format.js
      end
    end

    private

    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit!
    end

    def show_attributes
      %w[id created_at updated_at]
    end
  end
end
