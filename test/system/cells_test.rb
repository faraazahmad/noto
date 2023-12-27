require "application_system_test_case"

class CellsTest < ApplicationSystemTestCase
  setup do
    @cell = cells(:one)
  end

  test "visiting the index" do
    visit cells_url
    assert_selector "h1", text: "Cells"
  end

  test "should create cell" do
    visit cells_url
    click_on "New cell"

    fill_in "Content", with: @cell.content
    fill_in "Notebook", with: @cell.notebook_id
    fill_in "Output", with: @cell.output
    fill_in "Type", with: @cell.type
    click_on "Create Cell"

    assert_text "Cell was successfully created"
    click_on "Back"
  end

  test "should update Cell" do
    visit cell_url(@cell)
    click_on "Edit this cell", match: :first

    fill_in "Content", with: @cell.content
    fill_in "Notebook", with: @cell.notebook_id
    fill_in "Output", with: @cell.output
    fill_in "Type", with: @cell.type
    click_on "Update Cell"

    assert_text "Cell was successfully updated"
    click_on "Back"
  end

  test "should destroy Cell" do
    visit cell_url(@cell)
    click_on "Destroy this cell", match: :first

    assert_text "Cell was successfully destroyed"
  end
end
