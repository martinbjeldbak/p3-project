class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
      @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Velkommen til foodl, #{@user.email.split('@')[0]}!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def login
  end
end