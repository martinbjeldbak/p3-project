class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    if params[:register]
      @user = User.new
    elsif params[:login]
      
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def login
  end
end