require 'test_helper'

class TucdocsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tucdoc = tucdocs(:one)
  end

  test "should get index" do
    get tucdocs_url
    assert_response :success
  end

  test "should get new" do
    get new_tucdoc_url
    assert_response :success
  end

  test "should create tucdoc" do
    assert_difference('Tucdoc.count') do
      post tucdocs_url, params: { tucdoc: { amend_no: @tucdoc.amend_no, coagyear: @tucdoc.coagyear, item_no: @tucdoc.item_no, object_class_id: @tucdoc.object_class_id, project_id: @tucdoc.project_id } }
    end

    assert_redirected_to tucdoc_url(Tucdoc.last)
  end

  test "should show tucdoc" do
    get tucdoc_url(@tucdoc)
    assert_response :success
  end

  test "should get edit" do
    get edit_tucdoc_url(@tucdoc)
    assert_response :success
  end

  test "should update tucdoc" do
    patch tucdoc_url(@tucdoc), params: { tucdoc: { amend_no: @tucdoc.amend_no, coagyear: @tucdoc.coagyear, item_no: @tucdoc.item_no, object_class_id: @tucdoc.object_class_id, project_id: @tucdoc.project_id } }
    assert_redirected_to tucdoc_url(@tucdoc)
  end

  test "should destroy tucdoc" do
    assert_difference('Tucdoc.count', -1) do
      delete tucdoc_url(@tucdoc)
    end

    assert_redirected_to tucdocs_url
  end
end
