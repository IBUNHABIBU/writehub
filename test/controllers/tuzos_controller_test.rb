require "test_helper"

class TuzosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tuzo = tuzos(:one)
  end

  test "should get index" do
    get tuzos_url
    assert_response :success
  end

  test "should get new" do
    get new_tuzo_url
    assert_response :success
  end

  test "should create tuzo" do
    assert_difference("Tuzo.count") do
      post tuzos_url, params: { tuzo: { email: @tuzo.email, name: @tuzo.name, phone: @tuzo.phone } }
    end

    assert_redirected_to tuzo_url(Tuzo.last)
  end

  test "should show tuzo" do
    get tuzo_url(@tuzo)
    assert_response :success
  end

  test "should get edit" do
    get edit_tuzo_url(@tuzo)
    assert_response :success
  end

  test "should update tuzo" do
    patch tuzo_url(@tuzo), params: { tuzo: { email: @tuzo.email, name: @tuzo.name, phone: @tuzo.phone } }
    assert_redirected_to tuzo_url(@tuzo)
  end

  test "should destroy tuzo" do
    assert_difference("Tuzo.count", -1) do
      delete tuzo_url(@tuzo)
    end

    assert_redirected_to tuzos_url
  end
end
