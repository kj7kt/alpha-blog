class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(password: params[:session][:password])
    else
      flash.now[:alert] = "Your "
      render 'new'
    end
  end

  def destroy

  end
end
