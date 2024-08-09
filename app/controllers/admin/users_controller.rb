class Admin::UsersController < ApplicationController
  before_action :find_user,only: [:destroy]

  def new
   @user=User.new()
  end
  def index
    @users=User.all
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
  def destroy
    @user.destroy
    flash[:notice]="User is Deleted succesfully"
    redirect_to admin_users_path 
  end
  private 
  def user_params
    params.require(:user).permit(:name,:email)
  end
  def find_user
    @user=User.find(params[:id])
  end
end
