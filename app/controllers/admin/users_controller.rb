class Admin::UsersController < ApplicationController
  def new
   @user=User.new()
  end
  def create 
    @user = User.new(user_params)
    password = SecureRandom.hex(10)
    @user.password=password
    @user.password_confirmation = password
    if @user.save
      @user.send_reset_password_instructions
      redirect_to new_admin_user_path, notice: 'User Confirmation mail is send.'
    else
      render :new
    end
    
  end
  private 
  def user_params
    params.require(:user).permit(:name,:email)
  end
end
