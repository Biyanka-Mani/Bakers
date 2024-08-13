require "test_helper"

class Admin::ContactInfosControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_contact_infos_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_contact_infos_update_url
    assert_response :success
  end
end
