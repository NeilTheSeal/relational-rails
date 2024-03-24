require "rails_helper"

RSpec.describe "Schools Web Pages", type: :feature do # rubocop:disable Metrics/BlockLength
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
    @cu = School.create!(
      name: "University of Colorado, Boulder",
      location: "Boulder, CO",
      abet_accredited: true,
      student_capacity: 38_000
    )
    @party = School.create!(
      name: "Party University",
      location: "Tijuana, Mexico",
      abet_accredited: false,
      student_capacity: 100_000
    )
    @aaron = @harvard.students.create!(
      name: "Aaron Aaronson",
      age: 21,
      account_balance: 0,
      currently_enrolled: true
    )
    @bill = @harvard.students.create!(
      name: "Bill Bobberson",
      age: 19,
      account_balance: -200,
      currently_enrolled: true
    )
    @chase = @mit.students.create!(
      name: "Chase McChase",
      age: 25,
      account_balance: 0,
      currently_enrolled: false
    )
    @dan = @mit.students.create!(
      name: "Daniel O'Daniel",
      age: 35,
      account_balance: 25_000,
      currently_enrolled: true
    )
    @evan = @cu.students.create!(
      name: "Evan Evanston",
      age: 22,
      account_balance: -2000,
      currently_enrolled: true
    )
    @frodo = @cu.students.create!(
      name: "Frodo Baggins",
      age: 50,
      account_balance: 200_000,
      currently_enrolled: true
    )
    @gilbert = @party.students.create!(
      name: "Gilbert Gottfried",
      age: 67,
      account_balance: 0,
      currently_enrolled: false
    )
    @henry = @party.students.create!(
      name: "Henry Benry",
      age: 18,
      account_balance: 50,
      currently_enrolled: true
    )
  end

  describe "User story #1:" do
    describe "When I visit /schools" do
      it "displays the name of each school in the system" do
        visit "/schools"

        within "body" do
          expect(page).to have_content("Harvard University")
          expect(page).to have_content("Boulder, CO")
          expect(page).to have_content("yes")
          expect(page).to have_content("12000")
          expect(page).to have_content("no")
        end
      end
    end
  end

  describe "User story #2:" do
    describe "When I visit /schools/:id" do
      it "shows the school with that id and its attributes" do
        visit "/schools/#{@harvard.id}"

        within "body" do
          expect(page).to have_content("Harvard University")
          expect(page).to have_content("Cambridge, MA")
          expect(page).to_not have_content("Party University")
        end
      end
    end
  end
end