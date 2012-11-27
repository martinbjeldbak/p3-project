require 'bcrypt'

class UsersController < ApplicationController
  before_filter :logged_in_user, only: [:index, :edit, :update, :destroy] #:edit, :update
  before_filter :not_logged_in,  only: [:new]
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

  def login
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      log_in @user

      # Check if user has any saved items in the shopping list from session
      unless session[:list_items].nil?
        session[:list_items].map { |listItem| listItem.user = @user; listItem.id = nil; listItem.save }
        session[:list_items] = nil
      end

      flash[:success] = "Velkommen til foodl, #{@user.email.split('@')[0]}!"
      redirect_to root_path
    else
      #flash[:error] = "Lolnoob"
      render 'new'
    end
  end

  def edit
  end

  def update
    # Gets @user from correct_user
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Bruger slettet."
    redirect_to users_url
  end

  # Mailer? http://api.rubyonrails.org/classes/ActionMailer/Base.html
  #def forgotPassword
  #  @user = User.find_by_email(params[:email])
  #  random_password = Array.new(10).map { (65 + rand(58)).chr }.join
  #  @user.password = random_password
  #  @user.save!
  #  Mailer.create_and_deliver_password_change(@user, random_password)
  #end

  private

  def not_logged_in
    redirect_to root_url, notice: "Du er allerede logget ind." if logged_in?
  end

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