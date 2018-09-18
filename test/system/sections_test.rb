require "application_system_test_case"

class SectionsTest < ApplicationSystemTestCase
  setup do
    @section = sections(:one)
  end

  test "visiting the index" do
    visit sections_url
    assert_selector "h1", text: "Sections"
  end

  test "creating a Section" do
    visit sections_url
    click_on "New Section"

    fill_in "Course", with: @section.course_id
    fill_in "End Date", with: @section.end_date
    fill_in "Meeting Scheme", with: @section.meeting_scheme
    fill_in "Meeting Time", with: @section.meeting_time
    fill_in "Section Hours", with: @section.section_hours
    fill_in "Start Date", with: @section.start_date
    click_on "Create Section"

    assert_text "Section was successfully created"
    click_on "Back"
  end

  test "updating a Section" do
    visit sections_url
    click_on "Edit", match: :first

    fill_in "Course", with: @section.course_id
    fill_in "End Date", with: @section.end_date
    fill_in "Meeting Scheme", with: @section.meeting_scheme
    fill_in "Meeting Time", with: @section.meeting_time
    fill_in "Section Hours", with: @section.section_hours
    fill_in "Start Date", with: @section.start_date
    click_on "Update Section"

    assert_text "Section was successfully updated"
    click_on "Back"
  end

  test "destroying a Section" do
    visit sections_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Section was successfully destroyed"
  end
end
