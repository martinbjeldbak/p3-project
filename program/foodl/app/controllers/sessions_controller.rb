class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_url
    else
      flash[:error] = "Forkert brugernavn/kodeord kombination"
      redirect_to login_path(:email => params[:session][:email].downcase)
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
