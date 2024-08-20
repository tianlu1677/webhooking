# frozen_string_literal: true

module Admin
  class SchedulesController < Admin::ApplicationController
    before_action :set_schedule, only: %i[show edit update destroy]

    def index
      @q = Schedule.all.ransack(params[:q])
      @schedules = @q.result.order('schedules.id desc')
      @pagy, @schedules = pagy(@schedules, items: params[:per_page] || 20, page: params[:page])
    end

    def show; end

    def new
      @schedule = Schedule.new
    end

    def edit; end

    def create
      @schedule = Schedule.new(schedules_params)

      if @schedule.save
        redirect_to(admin_schedules_path, notice: 'create success')
      else
        render :new
      end
    end

    def update
      if @schedule.update(schedule_params)
        respond_to do |format|
          format.html { redirect_to(admin_schedules_path, notice: 'Update success') }
          format.js
        end
      else
        render :edit
      end
    end

    def destroy
      @schedule.destroy
      respond_to do |format|
        format.html { redirect_to admin_schedules_path, notice: 'Delete success' }
        format.js
      end
    end

    private

    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def schedule_params
      params.require(:schedule).permit!
    end
  end
end
