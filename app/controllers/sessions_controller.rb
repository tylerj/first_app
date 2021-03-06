class SessionsController < ApplicationController

  before_filter :signed_in_user,      :only   => [:new, :create]
  
  def new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate(params[:session][:email], 
                             params[:session][:password])
    
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render :new
    else
      flash[:success] = "You have successfully signed in!"
      sign_in user
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end