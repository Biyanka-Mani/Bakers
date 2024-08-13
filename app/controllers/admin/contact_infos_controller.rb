class Admin::ContactInfosController < ApplicationController
  before_action :require_admin
  before_action :authenticate_user!
  def edit
    @contact_info = ContactInfo.first_or_initialize
  end

  def update
    @contact_info = ContactInfo.first_or_initialize
    if @contact_info.update(contact_info_params)
      redirect_to edit_admin_contact_info_path, notice: 'Contact info updated successfully.'
    else
      render :edit
    end
  end
  private

  def contact_info_params
    params.require(:contact_info).permit(:phone, :email, :address, :website, :store_timings)
  end
  def require_admin
    if !current_user&.is_admin?
      flash[:alert]="Admin Featured Actions!"
      redirect_to admin_root_path
    end
   end
end
