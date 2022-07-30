# frozen_string_literal: true

module Admin
  class BackpacksController < Admin::ApplicationController
    before_action :set_backpack, only: %i[show edit update destroy]

    def index
      @q = Backpack.all.ransack(params[:q])
      @backpacks = @q.result.order('backpacks.id desc') # .page(params[:page] || 1).per(params[:per] || 10)
      @pagy, @backpacks = pagy(@backpacks, items: params[:per_page] || 20, page: params[:page])
    end

    def show; end

    def new
      @backpack = Backpack.new
    end

    def edit; end

    def create
      @backpack = Backpack.new(backpacks_params)

      if @backpack.save
        redirect_to(admin_backpacks_path, notice: '创建成功。')
      else
        render :new
      end
    end

    def update
      if @backpack.update(backpack_params)
        respond_to do |format|
          format.html { redirect_to(admin_backpacks_path, notice: '更新成功。') }
          format.js
        end
      else
        render :edit
      end
    end

    def destroy
      @backpack.destroy
      respond_to do |format|
        format.html { redirect_to admin_backpacks_path, notice: '删除成功.' }
        format.js
      end
    end

    private

    def set_backpack
      @backpack = Backpack.find(params[:id])
    end

    def backpack_params
      params.require(:backpack).permit!
    end
  end
end
