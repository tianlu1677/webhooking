# frozen_string_literal: true

class Admin::BackpacksController < Admin::ApplicationController
  before_action :set_backpacks, only: %i[show edit update destroy]

  def index
    @q = Backpack.all.ransack(params[:q])
    @backpacks = @q.result.order('backpacks.id desc')#.page(params[:page] || 1).per(params[:per] || 10)
    @pagy, @backpacks = pagy(@backpacks, items: params[:per_page] || 2, page: params[:page])
  end

  def show; end

  def new
    @backpacks = Backpack.new
  end

  def edit; end

  def create
    @backpacks = Backpack.new(backpacks_params)

    if @backpacks.save
      redirect_to(admin_backpacks_path, notice: '创建成功。')
    else
      render :new
    end
  end

  def update
    if @backpacks.update(backpacks_params)
      respond_to do |format|
        format.html { redirect_to(admin_backpacks_path, notice: '更新成功。') }
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @backpacks.destroy
    respond_to do |format|
      format.html { redirect_to admin_backpacks_path, notice: '删除成功.' }
      format.js
    end
  end

  private

  def set_backpacks
    @backpacks = Backpack.find(params[:id])
  end

  def backpacks_params
    params.require(:backpacks).permit!
  end

  def show_attributes
    %w[id created_at updated_at]
  end
end
