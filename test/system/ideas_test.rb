require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  setup do
    @idea = ideas(:one)
  end

  test "visiting the index" do
    visit ideas_url
    assert_selector "h1", text: "Ideas"
  end

  test "creating a Idea" do
    visit ideas_url
    click_on "New Idea"

    fill_in "Decription", with: @idea.decription
    fill_in "Domain", with: @idea.domain
    fill_in "Stake", with: @idea.stake
    fill_in "Title", with: @idea.title
    fill_in "User", with: @idea.user
    click_on "Create Idea"

    assert_text "Idea was successfully created"
    click_on "Back"
  end

  test "updating a Idea" do
    visit ideas_url
    click_on "Edit", match: :first

    fill_in "Decription", with: @idea.decription
    fill_in "Domain", with: @idea.domain
    fill_in "Stake", with: @idea.stake
    fill_in "Title", with: @idea.title
    fill_in "User", with: @idea.user
    click_on "Update Idea"

    assert_text "Idea was successfully updated"
    click_on "Back"
  end

  test "destroying a Idea" do
    visit ideas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Idea was successfully destroyed"
  end
end
