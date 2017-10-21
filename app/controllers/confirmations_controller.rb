class ConfirmationsController < ApplicationController

  def new
    @user = current_user
  end

  def create
  @user = User.find params[:user_id]
    if @user.verification_code == params[:verification_code]
     @user.confirm!
     session[:authenticated] = true

     flash[:notice] = "Welcome #{@user.first_name}. The Adventure Begins!"
     redirect_to dashboards_path
    else
     flash.now[:error] = "Verification code is incorrect."
     render :new
    end
  end

end
