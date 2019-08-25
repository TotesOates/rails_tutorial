# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :logged_in_user, only: %i[edit update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    set_user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    set_user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      flash[:danger] = 'Sorry, something messed up.'
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
    set_user

    if set_user.update_attributes(user_params)
      flash[:success] = 'Profile Updated'
      redirect_to @user
    else
      flash[:danger] = 'Profile Update Failed'
      render 'edit'
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = 'You do not have access, Please Log In'
      redirect_to login_url
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
