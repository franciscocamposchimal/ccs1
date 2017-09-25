require 'test_helper'

class WarrantiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @warranty = warranties(:one)
  end

  test "should get index" do
    get warranties_url
    assert_response :success
  end

  test "should get new" do
    get new_warranty_url
    assert_response :success
  end

  test "should create warranty" do
    assert_difference('Warranty.count') do
      post warranties_url, params: { warranty: { Garantia1: @warranty.Garantia1, Garantia2: @warranty.Garantia2, Garantia3: @warranty.Garantia3, Garantia4: @warranty.Garantia4, client_id: @warranty.client_id } }
    end

    assert_redirected_to warranty_url(Warranty.last)
  end

  test "should show warranty" do
    get warranty_url(@warranty)
    assert_response :success
  end

  test "should get edit" do
    get edit_warranty_url(@warranty)
    assert_response :success
  end

  test "should update warranty" do
    patch warranty_url(@warranty), params: { warranty: { Garantia1: @warranty.Garantia1, Garantia2: @warranty.Garantia2, Garantia3: @warranty.Garantia3, Garantia4: @warranty.Garantia4, client_id: @warranty.client_id } }
    assert_redirected_to warranty_url(@warranty)
  end

  test "should destroy warranty" do
    assert_difference('Warranty.count', -1) do
      delete warranty_url(@warranty)
    end

    assert_redirected_to warranties_url
  end
end
