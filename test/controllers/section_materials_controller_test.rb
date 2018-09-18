require 'test_helper'

class SectionMaterialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section_material = section_materials(:one)
  end

  test "should get index" do
    get section_materials_url
    assert_response :success
  end

  test "should get new" do
    get new_section_material_url
    assert_response :success
  end

  test "should create section_material" do
    assert_difference('SectionMaterial.count') do
      post section_materials_url, params: { section_material: { material_id: @section_material.material_id, section_id: @section_material.section_id } }
    end

    assert_redirected_to section_material_url(SectionMaterial.last)
  end

  test "should show section_material" do
    get section_material_url(@section_material)
    assert_response :success
  end

  test "should get edit" do
    get edit_section_material_url(@section_material)
    assert_response :success
  end

  test "should update section_material" do
    patch section_material_url(@section_material), params: { section_material: { material_id: @section_material.material_id, section_id: @section_material.section_id } }
    assert_redirected_to section_material_url(@section_material)
  end

  test "should destroy section_material" do
    assert_difference('SectionMaterial.count', -1) do
      delete section_material_url(@section_material)
    end

    assert_redirected_to section_materials_url
  end
end
