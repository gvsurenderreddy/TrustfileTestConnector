require 'test_helper'

class FakeConnnectionsControllerTest < ActionController::TestCase
  setup do
    @fake_connnection = fake_connnections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fake_connnections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fake_connnection" do
    assert_difference('FakeConnnection.count') do
      post :create, fake_connnection: { name: @fake_connnection.name, refund_count: @fake_connnection.refund_count, sale_count: @fake_connnection.sale_count, scenario: @fake_connnection.scenario, state: @fake_connnection.state }
    end

    assert_redirected_to fake_connnection_path(assigns(:fake_connnection))
  end

  test "should show fake_connnection" do
    get :show, id: @fake_connnection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fake_connnection
    assert_response :success
  end

  test "should update fake_connnection" do
    patch :update, id: @fake_connnection, fake_connnection: { name: @fake_connnection.name, refund_count: @fake_connnection.refund_count, sale_count: @fake_connnection.sale_count, scenario: @fake_connnection.scenario, state: @fake_connnection.state }
    assert_redirected_to fake_connnection_path(assigns(:fake_connnection))
  end

  test "should destroy fake_connnection" do
    assert_difference('FakeConnnection.count', -1) do
      delete :destroy, id: @fake_connnection
    end

    assert_redirected_to fake_connnections_path
  end
end
