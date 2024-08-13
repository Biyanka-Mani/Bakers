class Admin::ContactUsRequestsController < ApplicationController
  before_action :find_enquiry,only: [:show,:destroy]
  before_action :authenticate_user!
  before_action :require_admin,only:[:destroy]
  def index
    @contact_us_requests=ContactUsRequest.all
  end

  def show
    @request=@contact_us_request.message
  end


  def destroy
    @contact_us_request.destroy
    flash[:notice]="Message is Deleted succesfully"
    redirect_to admin_contact_us_requests_path

  end  

  private 

    def request_params
        params.require(:contact_us_request).permit(:customer_name,:customer_email,:message)
    end
    def find_enquiry
        @contact_us_request=ContactUsRequest.find(params[:id])
    end
    def require_admin
      unless current_user.is_admin?
        flash[:alert] = "Only admins can perform that action"
        redirect_to admin_root_path
      end 
    end

end
