require "rails_helper"

RSpec.describe "Students Web Pages", type: :feature do
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

  describe "User story #3:" do
    describe "When I visit /students" do
      it "displays each student in the system" do
        visit "/students"

        within "body" do
          expect(page).to have_content("Aaron Aaronson")
          expect(page).to have_content("19")
          expect(page).to have_content("$50.00")
          expect(page).to have_content("yes")
          expect(page).to have_content("no")
        end
      end
    end
  end

  describe "User story #4:" do
    describe "when I visit /students/:id" do
      it "displays the student with that id" do
        visit "/students/#{@evan.id}"

        within "body" do
          expect(page).to have_content("Evan Evanston")
          expect(page).to have_content("22")
          expect(page).to have_content("yes")
          expect(page).to_not have_content("Aaron Aaronson")
        end
      end
    end
  end
end
