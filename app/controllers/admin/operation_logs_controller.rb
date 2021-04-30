# frozen_string_literal: true

class Admin::OperationLogsController < Admin::ApplicationController
  before_action :set_operation_log, only: %i[show edit update destroy]

  def index
    @q = OperationLog.all.ransack(params[:q])
    @operation_logs = @q.result.order('operation_logs.id desc')#.page(params[:page] || 1).per(params[:per] || 10)
    @pagy, @operation_logs = pagy(@operation_logs, items: params[:per_page] || 2, page: params[:page])
  end

  def show; end

  def new
    @operation_log = OperationLog.new
  end

  def edit; end

  def create
    @operation_log = OperationLog.new(operation_log_params)

    if @operation_log.save
      redirect_to(admin_operation_logs_path, notice: '创建成功。')
    else
      render :new
    end
  end

  def update
    if @operation_log.update(operation_log_params)
      respond_to do |format|
        format.html { redirect_to(admin_operation_logs_path, notice: '更新成功。') }
        format.js
      end      
    else
      render :edit
    end
  end

  def destroy
    @operation_log.destroy    
    respond_to do |format|
      format.html { redirect_to admin_operation_logs_path, notice: '删除成功.' }
      format.js
    end    
  end

  private

  def set_operation_log
    @operation_log = OperationLog.find(params[:id])
  end

  def operation_log_params
    params.require(:operation_log).permit!
  end

  def show_attributes
    %w[id created_at updated_at]
  end
end
