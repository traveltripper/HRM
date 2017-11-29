require 'test_helper'

class HealthinsurancesControllerTest < ActionController::TestCase
  setup do
    @healthinsurance = healthinsurances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:healthinsurances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create healthinsurance" do
    assert_difference('Healthinsurance.count') do
      post :create, healthinsurance: { card_number: @healthinsurance.card_number, employee_id: @healthinsurance.employee_id, issued_date: @healthinsurance.issued_date, name: @healthinsurance.name, policy_end_date: @healthinsurance.policy_end_date, policy_start_date: @healthinsurance.policy_start_date, relation: @healthinsurance.relation }
    end

    assert_redirected_to healthinsurance_path(assigns(:healthinsurance))
  end

  test "should show healthinsurance" do
    get :show, id: @healthinsurance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @healthinsurance
    assert_response :success
  end

  test "should update healthinsurance" do
    patch :update, id: @healthinsurance, healthinsurance: { card_number: @healthinsurance.card_number, employee_id: @healthinsurance.employee_id, issued_date: @healthinsurance.issued_date, name: @healthinsurance.name, policy_end_date: @healthinsurance.policy_end_date, policy_start_date: @healthinsurance.policy_start_date, relation: @healthinsurance.relation }
    assert_redirected_to healthinsurance_path(assigns(:healthinsurance))
  end

  test "should destroy healthinsurance" do
    assert_difference('Healthinsurance.count', -1) do
      delete :destroy, id: @healthinsurance
    end

    assert_redirected_to healthinsurances_path
  end
end
