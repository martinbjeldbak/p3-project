class SessionsController < ApplicationController
  def new
    #redirect_to 'users/new'
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user and user.authenticate(params[:session][:password])
      # Sign user in and redirect to homepage?
    else
      flash[:error] = "Forkert brugernavn/kodeord kombination"
      render 'users/new'
    end
    #render 'user/new'
    render 'new'
  end

  def destroy
  end
end
