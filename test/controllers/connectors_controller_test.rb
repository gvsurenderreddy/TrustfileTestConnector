require 'test_helper'

class ConnectorsControllerTest < ActionController::TestCase
  setup do
    @connector = connectors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:connectors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create connector" do
    assert_difference('Connector.count') do
      post :create, connector: { enabled: @connector.enabled, last_updated_at: @connector.last_updated_at, user_count: @connector.user_count }
    end

    assert_redirected_to connector_path(assigns(:connector))
  end

  test "should show connector" do
    get :show, id: @connector
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @connector
    assert_response :success
  end

  test "should update connector" do
    patch :update, id: @connector, connector: { enabled: @connector.enabled, last_updated_at: @connector.last_updated_at, user_count: @connector.user_count }
    assert_redirected_to connector_path(assigns(:connector))
  end

  test "should destroy connector" do
    assert_difference('Connector.count', -1) do
      delete :destroy, id: @connector
    end

    assert_redirected_to connectors_path
  end
end
