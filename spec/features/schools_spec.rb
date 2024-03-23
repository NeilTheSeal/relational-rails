require "rails_helper"

RSpec.describe "Schools Index Page", type: :feature do
  before(:each) do
    @harvard = School.create!(
      name: "Harvard University",
      location: "Cambridge, MA",
      abet_accredited: true,
      student_capacity: 22_000
    )
    @mit = School.create!(
      name: "Massachusetts Institute of Technology",
      location: "Cambridge, MA",
      abet_accredited: true,
      student_capacity: 12_000
    )
    @harvard = School.create!(
      name: "University of Colorado, Boulder",
      location: "Boulder, CO",
      abet_accredited: true,
      student_capacity: 38_000
    )
  end

  describe "User story #1:" do
    # For each parent table
    # As a visitor
    # When I visit '/parents'
    # Then I see the name of each parent record in the system
    describe "When I visit /schools" do
      it "displays the name of each school in the system" do
        visit "/schools"

        within "body" do
          expect(page).to have_content("Harvard University")
          expect(page).to have_content("Boulder, CO")
          expect(page).to have_content("true")
          expect(page).to have_content("12000")
        end
      end
    end
  end
end
