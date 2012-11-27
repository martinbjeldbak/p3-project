class IssuesController < ApplicationController
  before_filter :logged_in_user, only: [:index] #:edit, :update
  before_filter :admin_user,     only: [:index]

  def index
    @user = current_user
  end

  def new

  end

  private

  def logged_in_user
    redirect_to login_url, notice: "Log venligst ind." unless logged_in?
  end

  def admin_user
    redirect_to root_path, notice: "Det har du ikke tilladelse til!" unless current_user.admin?
  end
end
