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
    @bill = @harvard.students.create!(
      name: "Bill Bobberson",
      age: 19,
      account_balance: -200,
      currently_enrolled: true
    )
    @aaron = @harvard.students.create!(
      name: "Aaron Aaronson",
      age: 21,
      account_balance: 0,
      currently_enrolled: true
    )
    @dan = @mit.students.create!(
      name: "Daniel O'Daniel",
      age: 35,
      account_balance: 25_000,
      currently_enrolled: true
    )
    @chase = @mit.students.create!(
      name: "Chase McChase",
      age: 25,
      account_balance: 0,
      currently_enrolled: false
    )
    @frodo = @cu.students.create!(
      name: "Frodo Baggins",
      age: 50,
      account_balance: 200_000,
      currently_enrolled: true
    )
    @evan = @cu.students.create!(
      name: "Evan Evanston",
      age: 22,
      account_balance: -2000,
      currently_enrolled: true
    )
    @henry = @party.students.create!(
      name: "Henry Benry",
      age: 18,
      account_balance: 50,
      currently_enrolled: true
    )
    @gilbert = @party.students.create!(
      name: "Gilbert Gottfried",
      age: 67,
      account_balance: 0,
      currently_enrolled: false
    )
  end

  describe "User story #3, #15:" do
    describe "When I visit /students" do
      it "displays each currently enrolled student in the system" do
        visit "/students"

        within "body" do
          expect(page).to have_content("Aaron Aaronson")
          expect(page).to have_content("19")
          expect(page).to have_content("$50.00")
          expect(page).to have_content("yes")
          expect(page).to_not have_content("no")
        end
      end

      it "has a link to edit each student" do
        visit "/students"

        expect(page.has_css?("#edit-#{@aaron.id}")).to eq(true)
        find("#edit-#{@aaron.id}").click
        expect(page.current_path).to eq("/students/#{@aaron.id}/edit")
      end
    end
  end

  describe "User story #4, #14, #20:" do
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

      it "has a link to update the student info" do
        visit "/students/#{@evan.id}"

        click_link("update-student-link")
        expect(page).to have_current_path("/students/#{@evan.id}/edit")
      end

      it "has a link to delete the student" do
        visit "/students/#{@aaron.id}"

        expect(page.has_css?("#delete-student-link")).to eq(true)
      end

      it "can delete the student" do
        visit "/students/#{@aaron.id}"

        find("#delete-student-link").click
        expect(page.current_path).to eq("/students")

        expect(page).to_not have_content("Aaron Aaronson")
      end
    end

    describe "When I visit students/:id/edit" do
      it "has a form to edit a student record" do
        visit "/students/#{@evan.id}/edit"

        within "body" do
          expect(page).to have_element("div", class: "form-description")
          expect(page).to have_element("form", id: "edit-student-form")
          expect(page).to have_element("input", id: "student-name")
          expect(page).to have_element("input", id: "student-age")
          expect(page).to have_element("input", id: "student-enrolled")
          expect(page).to have_element("input", id: "student-balance")
          expect(page).to have_element("input", type: "submit")
        end
      end

      it "can update a student record" do
        visit "/students/#{@evan.id}/edit"

        fill_in("student-name", with: "Student 2")
        fill_in("student-age", with: "55")
        uncheck("student-enrolled")
        fill_in("student-balance", with: "100")

        find('input[type="submit"]').click

        expect(page.current_path).to eq("/students/#{@evan.id}")

        expect(page).to have_content("Student 2")
        expect(page).to have_content("no")
        expect(page).to have_content("55")
        expect(page).to have_content("100")
      end
    end
  end
end
