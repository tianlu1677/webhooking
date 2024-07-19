# frozen_string_literal: true

module Admin
  class RequestsController < Admin::ApplicationController
    before_action :set_request, only: %i[show edit update destroy]

    def index
      @q = Request.all.ransack(params[:q])
      @requests = @q.result.order('requests.id desc') # .page(params[:page] || 1).per(params[:per] || 10)
      @pagy, @requests = pagy(@requests, items: params[:per_page] || 20, page: params[:page])
    end

    def show; end

    def new
      @request = Request.new
    end

    def edit; end

    def create
      @request = Request.new(requests_params)

      if @request.save
        redirect_to(admin_requests_path, notice: '创建成功。')
      else
        render :new
      end
    end

    def update
      if @request.update(request_params)
        respond_to do |format|
          format.html { redirect_to(admin_requests_path, notice: '更新成功。') }
          format.js
        end
      else
        render :edit
      end
    end

    def destroy
      @request.destroy
      respond_to do |format|
        format.html { redirect_to admin_requests_path, notice: '删除成功.' }
        format.js
      end
    end

    private

    def set_request
      @request = Request.find(params[:id])
    end

    def request_params
      params.require(:request).permit!
    end
  end
end
