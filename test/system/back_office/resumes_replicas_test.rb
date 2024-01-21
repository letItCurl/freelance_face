require "application_system_test_case"
# copy for resume controller
class BackOffice::ResumesTest < ApplicationSystemTestCase
  setup do
    @resume = back_office_resumes(:one)
  end

  test "visiting the index" do
    visit back_office_resumes_url
    assert_selector "h1", text: "Resumes"
  end

  test "should create resume" do
    visit back_office_resumes_url
    click_on "New resume"

    click_on "Create Resume"

    assert_text "Resume was successfully created"
    click_on "Back"
  end

  test "should update Resume" do
    visit back_office_resume_url(@resume)
    click_on "Edit this resume", match: :first

    click_on "Update Resume"

    assert_text "Resume was successfully updated"
    click_on "Back"
  end

  test "should destroy Resume" do
    visit back_office_resume_url(@resume)
    click_on "Destroy this resume", match: :first

    assert_text "Resume was successfully destroyed"
  end
end
