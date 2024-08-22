require 'rails_helper'

RSpec.describe Admin::ContactInfosController, type: :request do
  let(:admin_user) { create(:user, is_admin: :true) }
  let(:non_admin_user) { create(:user) }
  let!(:contact_info) { create(:contact_info) }

  before do
    sign_in admin_user
  end

  describe 'GET #edit' do
    it 'assigns @contact_info' do
      get edit_admin_contact_info_path
      expect(assigns(:contact_info)).to be_a(ContactInfo)
    end

    it 'renders the edit template' do
      get edit_admin_contact_info_path
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the contact info' do
        put admin_contact_info_path, params: { contact_info: { phone: '987-654-3210' } }
        expect(contact_info.reload.phone).to eq('987-654-3210')
      end

      it 'redirects to the edit page with a success notice' do
        put admin_contact_info_path, params: { contact_info: { phone: '987-654-3210' } }
        expect(response).to redirect_to(edit_admin_contact_info_path)
        expect(flash[:notice]).to eq('Contact info updated successfully.')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the contact info and re-renders the edit template' do
        put admin_contact_info_path, params: { contact_info: { phone: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'admin access control' do
    context 'when the user is not an admin' do
      before do
        sign_out admin_user
        sign_in non_admin_user
      end

      it 'redirects to the admin root path with an alert' do
        get edit_admin_contact_info_path
        expect(response).to redirect_to(admin_root_path)
        expect(flash[:alert]).to eq('Admin Featured Actions!')
      end
    end
  end
end

