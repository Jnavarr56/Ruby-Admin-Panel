require "application_system_test_case"

class SectionMaterialsTest < ApplicationSystemTestCase
  setup do
    @section_material = section_materials(:one)
  end

  test "visiting the index" do
    visit section_materials_url
    assert_selector "h1", text: "Section Materials"
  end

  test "creating a Section material" do
    visit section_materials_url
    click_on "New Section Material"

    fill_in "Material", with: @section_material.material_id
    fill_in "Section", with: @section_material.section_id
    click_on "Create Section material"

    assert_text "Section material was successfully created"
    click_on "Back"
  end

  test "updating a Section material" do
    visit section_materials_url
    click_on "Edit", match: :first

    fill_in "Material", with: @section_material.material_id
    fill_in "Section", with: @section_material.section_id
    click_on "Update Section material"

    assert_text "Section material was successfully updated"
    click_on "Back"
  end

  test "destroying a Section material" do
    visit section_materials_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Section material was successfully destroyed"
  end
end
