require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :request do
  let(:user) { create(:user) } # Assuming you have a user factory
  let!(:category) { create(:category) } 

  before do
    sign_in user
  end

  describe "GET #index" do
   
    it "assigns all categories to @categories" do
      get admin_categories_path
      expect(assigns(:categories)).to eq([category])
    end

    it "assigns a new category to @category" do
      get admin_categories_path
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe "GET #new" do
    it "assigns a new category to @category" do
      get new_admin_category_path
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) { { category: attributes_for(:category) } }

      it "creates a new Category" do
        expect {
          post admin_categories_path, params: valid_params
        }.to change(Category, :count).by(1)
      end

      it "redirects to the categories index" do
        post admin_categories_path, params: valid_params
        expect(response).to redirect_to(admin_categories_path)
      end

      it "sets a flash notice" do
        post admin_categories_path, params: valid_params
        expect(flash[:notice]).to eq("Category is saved successfully")
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { category: attributes_for(:category, name: nil) } }

      it "does not create a new Category" do
        expect {
          post admin_categories_path, params: invalid_params
        }.not_to change(Category, :count)
      end

      it "renders turbo_stream for HTML format" do
        post admin_categories_path, params: invalid_params, headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
        expect(response.media_type).to eq Mime[:turbo_stream]
        expect(response.body).to include('category_form_modal') # Ensure the modal is being replaced
        expect(response.body).to include("Name can&#39;t be blank")
        expect(response.body).to include("Name is too short (minimum is 3 characters)")
        # Optional: Check for the presence of the error class
        expect(response.body).to include("class=\"text-danger\"")
      end
      

     
    end
  end

  describe "DELETE #destroy" do
    context "when category has no associated products" do
      it "destroys the requested category" do
        category = create(:category)
        expect {
          delete admin_category_path(category), params: { id: category.id }
        }.to change(Category, :count).by(-1)
      end

      it "redirects to the categories list" do
        delete admin_category_path(category), params: { id: category.id }
        expect(response).to redirect_to(admin_categories_path)
      end

      it "sets a flash notice" do
        delete admin_category_path(category), params: { id: category.id }
        expect(flash[:notice]).to eq("Category successfully deleted.")
      end
    end

    context "when category has associated products" do
      it "does not destroy the category" do
        category = create(:category)
        create(:product, category: category) # Assuming you have a product factory
        expect {
          delete admin_category_path(category), params: { id: category.id }
        }.not_to change(Category, :count)
      end

      it "redirects to the category path" do
        category = create(:category)
        create(:product, category: category)
        delete admin_category_path(category), params: { id: category.id }
        expect(response).to redirect_to(admin_category_path)
      end

      it "sets a flash alert" do
        category = create(:category)
        create(:product, category: category)
        delete admin_category_path(category), params: { id: category.id }
        expect(flash[:alert]).to eq("Cannot delete category with associated products.")
      end
    end
  end
end
