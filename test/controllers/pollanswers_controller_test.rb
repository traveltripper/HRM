require 'test_helper'

class PollanswersControllerTest < ActionController::TestCase
  setup do
    @pollanswer = pollanswers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pollanswers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pollanswer" do
    assert_difference('Pollanswer.count') do
      post :create, pollanswer: { option: @pollanswer.option, pollquestion_id: @pollanswer.pollquestion_id, status: @pollanswer.status }
    end

    assert_redirected_to pollanswer_path(assigns(:pollanswer))
  end

  test "should show pollanswer" do
    get :show, id: @pollanswer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pollanswer
    assert_response :success
  end

  test "should update pollanswer" do
    patch :update, id: @pollanswer, pollanswer: { option: @pollanswer.option, pollquestion_id: @pollanswer.pollquestion_id, status: @pollanswer.status }
    assert_redirected_to pollanswer_path(assigns(:pollanswer))
  end

  test "should destroy pollanswer" do
    assert_difference('Pollanswer.count', -1) do
      delete :destroy, id: @pollanswer
    end

    assert_redirected_to pollanswers_path
  end
end
