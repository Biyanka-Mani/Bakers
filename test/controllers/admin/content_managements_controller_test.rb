require "test_helper"

class Admin::ContentManagementsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_content_managements_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_content_managements_update_url
    assert_response :success
  end
end
