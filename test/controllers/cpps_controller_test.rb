require 'test_helper'

class CppsControllerTest < ActionController::TestCase
  setup do
    @cpp = cpps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cpps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cpp" do
    assert_difference('Cpp.count') do
      post :create, cpp: { description: @cpp.description }
    end

    assert_redirected_to cpp_path(assigns(:cpp))
  end

  test "should show cpp" do
    get :show, id: @cpp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cpp
    assert_response :success
  end

  test "should update cpp" do
    patch :update, id: @cpp, cpp: { description: @cpp.description }
    assert_redirected_to cpp_path(assigns(:cpp))
  end

  test "should destroy cpp" do
    assert_difference('Cpp.count', -1) do
      delete :destroy, id: @cpp
    end

    assert_redirected_to cpps_path
  end
end
