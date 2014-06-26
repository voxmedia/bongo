require 'test_helper'

class FontSetsControllerTest < ActionController::TestCase
  setup do
    @font_set = font_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:font_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create font_set" do
    assert_difference('FontSet.count') do
      post :create, font_set: { project_id: @font_set.project_id, sass: @font_set.sass }
    end

    assert_redirected_to font_set_path(assigns(:font_set))
  end

  test "should show font_set" do
    get :show, id: @font_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @font_set
    assert_response :success
  end

  test "should update font_set" do
    patch :update, id: @font_set, font_set: { project_id: @font_set.project_id, sass: @font_set.sass }
    assert_redirected_to font_set_path(assigns(:font_set))
  end

  test "should destroy font_set" do
    assert_difference('FontSet.count', -1) do
      delete :destroy, id: @font_set
    end

    assert_redirected_to font_sets_path
  end
end
