require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get add_user" do
    get :add_user
    assert_response :success
  end

  test "should get edit_user" do
    get :edit_user
    assert_response :success
  end

  test "should get delete_user" do
    get :delete_user
    assert_response :success
  end

  test "should get list_users" do
    get :list_users
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

end
