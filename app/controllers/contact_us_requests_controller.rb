class ContactUsRequestsController < ApplicationController
    before_action :find_enquiry,only: [:show,:destroy]
    before_action :require_admin, except:[:new,:create]
    def index
      @contact_us_requests=ContactUsRequest.all
    end
  
    def show
      @request=@contact_us_request.message
    end
  
    def new
      @contact_us_request = ContactUsRequest.new
    end
  
    def create
      @request=ContactUsRequest.create(request_params)
      if @request.save
          flash[:notice]="Message Created Successfully"
          render :new,status: :unprocessable_entity
      else
          flash.now[:alert]="Message Creation Error Occured"
          render :new,status: :unprocessable_entity
      end
    end
  
  
    def destroy
      @category.destroy
      flash[:notice]="Message is Deleted succesfully"
      redirect_to contact_us_requests_path
  
    end  
  
    private 
  
      def request_params
          params.require(:contact_us_request).permit(:customer_name,:customer_email,:message)
      end
      def find_category
          @contact_us_request=ContactUsRequest.find(params[:id])
      end
      def require_admin
        unless current_user.is_admin?
          flash[:alert] = "Only admins can perform that action"
          redirect_to categories_path
        end 
      end

end
