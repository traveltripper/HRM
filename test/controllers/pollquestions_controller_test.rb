require 'test_helper'

class PollquestionsControllerTest < ActionController::TestCase
  setup do
    @pollquestion = pollquestions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pollquestions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pollquestion" do
    assert_difference('Pollquestion.count') do
      post :create, pollquestion: { question: @pollquestion.question, status: @pollquestion.status }
    end

    assert_redirected_to pollquestion_path(assigns(:pollquestion))
  end

  test "should show pollquestion" do
    get :show, id: @pollquestion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pollquestion
    assert_response :success
  end

  test "should update pollquestion" do
    patch :update, id: @pollquestion, pollquestion: { question: @pollquestion.question, status: @pollquestion.status }
    assert_redirected_to pollquestion_path(assigns(:pollquestion))
  end

  test "should destroy pollquestion" do
    assert_difference('Pollquestion.count', -1) do
      delete :destroy, id: @pollquestion
    end

    assert_redirected_to pollquestions_path
  end
end
