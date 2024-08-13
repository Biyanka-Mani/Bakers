class HomeController < ApplicationController
  before_action :redirect_if_signed_in
  def index
    @featured_products = Product.where(active: true).order(created_at: :desc).limit(3)
    @categories = Category.all

    @content_management = ContentManagement.first
 
  end
  def aboutus
    @content_management = ContentManagement.first
  end
  def redirect_if_signed_in
    if user_signed_in?
      redirect_to  admin_root_path 
    end
  end
end
