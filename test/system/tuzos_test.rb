require "application_system_test_case"

class TuzosTest < ApplicationSystemTestCase
  setup do
    @tuzo = tuzos(:one)
  end

  test "visiting the index" do
    visit tuzos_url
    assert_selector "h1", text: "Tuzos"
  end

  test "should create tuzo" do
    visit tuzos_url
    click_on "New tuzo"

    fill_in "Email", with: @tuzo.email
    fill_in "Name", with: @tuzo.name
    fill_in "Phone", with: @tuzo.phone
    click_on "Create Tuzo"

    assert_text "Tuzo was successfully created"
    click_on "Back"
  end

  test "should update Tuzo" do
    visit tuzo_url(@tuzo)
    click_on "Edit this tuzo", match: :first

    fill_in "Email", with: @tuzo.email
    fill_in "Name", with: @tuzo.name
    fill_in "Phone", with: @tuzo.phone
    click_on "Update Tuzo"

    assert_text "Tuzo was successfully updated"
    click_on "Back"
  end

  test "should destroy Tuzo" do
    visit tuzo_url(@tuzo)
    click_on "Destroy this tuzo", match: :first

    assert_text "Tuzo was successfully destroyed"
  end
end
