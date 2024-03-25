require "rails_helper"

RSpec.describe "All Web Pages", type: :feature do
  describe "User story #8 and #9" do
    it "shows a link to the student index on every page" do
      visit "/"

      click_link("students-link")
      expect(page).to have_current_path("/students")

      visit "/schools"
      click_link("students-link")
      expect(page).to have_current_path("/students")
    end

    it "shows a link to the schools index on every page" do
      visit "/"

      click_link("schools-link")
      expect(page).to have_current_path("/schools")

      visit "/students"
      click_link("schools-link")
      expect(page).to have_current_path("/schools")
    end
  end
end
