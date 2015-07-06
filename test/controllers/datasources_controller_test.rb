require 'test_helper'

class DatasourcesControllerTest < ActionController::TestCase
  setup do
    @datasource = datasources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:datasources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create datasource" do
    assert_difference('Datasource.count') do
      post :create, datasource: { authorized: @datasource.authorized, company_2_tf_token: @datasource.company_2_tf_token, enabled: @datasource.enabled, last_sync_at: @datasource.last_sync_at, next_sync_at: @datasource.next_sync_at, start_date: @datasource.start_date, status_changed_at: @datasource.status_changed_at, status_message: @datasource.status_message }
    end

    assert_redirected_to datasource_path(assigns(:datasource))
  end

  test "should show datasource" do
    get :show, id: @datasource
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @datasource
    assert_response :success
  end

  test "should update datasource" do
    patch :update, id: @datasource, datasource: { authorized: @datasource.authorized, company_2_tf_token: @datasource.company_2_tf_token, enabled: @datasource.enabled, last_sync_at: @datasource.last_sync_at, next_sync_at: @datasource.next_sync_at, start_date: @datasource.start_date, status_changed_at: @datasource.status_changed_at, status_message: @datasource.status_message }
    assert_redirected_to datasource_path(assigns(:datasource))
  end

  test "should destroy datasource" do
    assert_difference('Datasource.count', -1) do
      delete :destroy, id: @datasource
    end

    assert_redirected_to datasources_path
  end
end
