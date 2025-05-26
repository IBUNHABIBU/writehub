require "application_system_test_case"

class UserLocationsTest < ApplicationSystemTestCase
  setup do
    @user_location = user_locations(:one)
  end

  test "visiting the index" do
    visit user_locations_url
    assert_selector "h1", text: "User locations"
  end

  test "should create user location" do
    visit user_locations_url
    click_on "New user location"

    fill_in "City", with: @user_location.city
    fill_in "Latitude", with: @user_location.latitude
    fill_in "Longitude", with: @user_location.longitude
    click_on "Create User location"

    assert_text "User location was successfully created"
    click_on "Back"
  end

  test "should update User location" do
    visit user_location_url(@user_location)
    click_on "Edit this user location", match: :first

    fill_in "City", with: @user_location.city
    fill_in "Latitude", with: @user_location.latitude
    fill_in "Longitude", with: @user_location.longitude
    click_on "Update User location"

    assert_text "User location was successfully updated"
    click_on "Back"
  end

  test "should destroy User location" do
    visit user_location_url(@user_location)
    click_on "Destroy this user location", match: :first

    assert_text "User location was successfully destroyed"
  end
end
