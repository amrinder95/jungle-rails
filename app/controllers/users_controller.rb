class UsersController < ApplicationController
  def new
  end

  def create
    if user_params[:password].length < 6 || user_params[:password_confirmation].length < 6
      flash[:error] = "Password must be atleast 6 characters"
      redirect_to '/signup'
    elsif User.exists?(:email => user_params[:email].downcase)
      flash[:error] = "Email already exists"
      redirect_to '/signup'
    else
      user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        redirect_to '/'
      else
        redirect_to '/signup'
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
  
end
