require 'bcrypt'

class UsersController < ApplicationController
  before_filter :logged_in_user, only: [:edit, :update, :destroy] #:edit, :update
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:index, :destroy]

  include BCrypt

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  #Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx Check for password og password_confirmation
  def create
    @user = User.new(params[:user])
    if @user.save
      log_in @user
      flash[:success] = "Velkommen til foodl, #{@user.email.split('@')[0]}!"
      redirect_to root_path
    else
      render 'login'
    end
  end

  def edit
    # Gets @user from correct_user...

  end

  def update
    # Also gets @user from correct_user
    passwordEquality = BCrypt::Password.new(@user.password_digest) == params[:user][:old_password]
    formInfo = params[:user]

    if passwordEquality and @user.update_attributes(password: formInfo[:password], password_confirmation: formInfo[:password_confirmation], email: formInfo[:email])
      flash[:success] = "Profil opdateret"
      log_in @user
      redirect_to root_path
    else
      if !passwordEquality
        flash[:error] = "Dit nuvaerende kodeord er ikke rigtigt"
      end
      render 'edit'
    end
  end

  def login
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Bruger slettet."
    redirect_to users_url
  end

  private

  def logged_in_user
    redirect_to login_url, notice: "Log venligst ind." unless logged_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path, notice: "Det har du ikke tilladelse til" unless current_user?(@user)
  end

  def admin_user
    redirect_to root_path, notice: "Det har du ikke tilladelse til!" unless current_user.admin?
  end
end