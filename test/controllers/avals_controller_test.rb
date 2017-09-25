require 'test_helper'

class AvalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @aval = avals(:one)
  end

  test "should get index" do
    get avals_url
    assert_response :success
  end

  test "should get new" do
    get new_aval_url
    assert_response :success
  end

  test "should create aval" do
    assert_difference('Aval.count') do
      post avals_url, params: { aval: { Apellidos: @aval.Apellidos, INE: @aval.INE, Nombre: @aval.Nombre } }
    end

    assert_redirected_to aval_url(Aval.last)
  end

  test "should show aval" do
    get aval_url(@aval)
    assert_response :success
  end

  test "should get edit" do
    get edit_aval_url(@aval)
    assert_response :success
  end

  test "should update aval" do
    patch aval_url(@aval), params: { aval: { Apellidos: @aval.Apellidos, INE: @aval.INE, Nombre: @aval.Nombre } }
    assert_redirected_to aval_url(@aval)
  end

  test "should destroy aval" do
    assert_difference('Aval.count', -1) do
      delete aval_url(@aval)
    end

    assert_redirected_to avals_url
  end
end
