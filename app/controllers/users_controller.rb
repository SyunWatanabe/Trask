# frozen_string_literal: true

class UsersController < ApplicationController
  require 'will_paginate/array'
  before_action :logged_in_user, only: %i[edit update index destroy]
  before_action :admin_user,     only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @questions_answers_array = @user.questions.to_a.concat(@user.answers.to_a)
    @questions_answers_arraies = @questions_answers_array.sort { |f, s| f.created_at <=> s.created_at }.reverse.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'ユーザー登録しました！'
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.where(id: current_user.id).first
    if @user.update_attributes(user_params)
      flash[:success] = 'ユーザー情報を変更しました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.where(id: current_user.id).first
    @user.destroy
    flash[:success] = 'ユーザーを削除しました'
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
