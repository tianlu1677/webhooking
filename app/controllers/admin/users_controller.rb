# frozen_string_literal: true

class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @q = User.all.ransack(params[:q])
    @users = @q.result.order('users.id desc')#.page(params[:page] || 1).per(params[:per] || 10)

    @pagy, @users = pagy(@users, per_page: params[:per_page], page: params[:page])
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to(admin_users_path, notice: '创建成功。')
    else
      render :new
    end
  end

  def update    
    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to(admin_users_path, notice: '更新成功。') }
        format.js
      end      
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to(admin_users_path, notice: '删除成功。')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit!
  end
end
