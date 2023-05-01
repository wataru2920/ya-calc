require "application_system_test_case"

class CalcsTest < ApplicationSystemTestCase
  setup do
    @calc = calcs(:one)
  end

  test "visiting the index" do
    visit calcs_url
    assert_selector "h1", text: "Calcs"
  end

  test "creating a Calc" do
    visit calcs_url
    click_on "New Calc"

    fill_in "Daily", with: @calc.daily
    fill_in "Food", with: @calc.food
    fill_in "Housing", with: @calc.housing
    fill_in "Others", with: @calc.others
    fill_in "Recreation", with: @calc.recreation
    fill_in "Traffic", with: @calc.traffic
    click_on "Create Calc"

    assert_text "Calc was successfully created"
    click_on "Back"
  end

  test "updating a Calc" do
    visit calcs_url
    click_on "Edit", match: :first

    fill_in "Daily", with: @calc.daily
    fill_in "Food", with: @calc.food
    fill_in "Housing", with: @calc.housing
    fill_in "Others", with: @calc.others
    fill_in "Recreation", with: @calc.recreation
    fill_in "Traffic", with: @calc.traffic
    click_on "Update Calc"

    assert_text "Calc was successfully updated"
    click_on "Back"
  end

  test "destroying a Calc" do
    visit calcs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Calc was successfully destroyed"
  end
end
