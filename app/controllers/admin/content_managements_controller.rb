class Admin::ContentManagementsController < ApplicationController
  before_action :require_admin
  before_action :authenticate_user!

  def edit
    @content_management = ContentManagement.first
  end

  def update
    @content_management = ContentManagement.first
    if @content_management.update(content_management_params)
      redirect_to admin_content_management_path, notice: 'Content updated successfully.'
    else
       flash[:alert]="ContentError is Occured"
      render :edit,status: :unprocessable_entity
    end
  end

  private

  def content_management_params
    params.require(:content_management).permit(
      :home_page_category_header,
      :home_page_category_description,
      :home_page_baking_header,
      :home_page_baking_description,
      :baking_image,
      :about_us_header,
      :about_us_story,
      :master_baker_header,
      :master_baker_description,
      :master_baker_image
    )
  end
  def require_admin
    if !current_user&.is_admin?
      flash[:alert]="Admin Featured Actions!"
      redirect_to admin_root_path
    end
   end
end
