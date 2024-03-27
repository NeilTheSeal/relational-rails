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

  describe "User story #1, #6, #17:" do
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

      it "displays the schools in order of creation" do
        visit "/schools"

        expect(@party.name).to appear_before(@cu.name)
        expect(@cu.name).to appear_before(@mit.name)
        expect(@mit.name).to appear_before(@harvard.name)
      end

      it "has a link to add a new school" do
        visit "/schools"

        click_link("create-school-link")
        expect(page).to have_current_path("/schools/new")
      end

      it "has a link to edit a school" do
        visit "/schools"

        expect(page.has_css?("#edit-#{@harvard.id}")).to eq(true)
        find("#edit-#{@harvard.id}").click
        expect(page.current_path).to eq("/schools/#{@harvard.id}/edit")
      end

      it "has a link to delete a school" do
        visit "/schools"

        expect(page.has_css?("#delete-school-#{@harvard.id}-link")).to eq(true)
      end

      it "can delete a school" do
        visit "/schools"

        find("#delete-school-#{@harvard.id}-link").click
        expect(page.current_path).to eq("/schools")

        expect(page).to_not have_content("Harvard University")
      end
    end
  end

  describe "User story #2, #7, #10, #12, #19:" do
    describe "When I visit /schools/:id" do
      it "shows the school with that id and its attributes" do
        visit "/schools/#{@harvard.id}"

        within "body" do
          expect(page).to have_content("Harvard University")
          expect(page).to have_content("Cambridge, MA")
          expect(page).to_not have_content("Party University")
        end
      end

      it "shows the number of students associated with the school" do
        visit "/schools/#{@harvard.id}"

        within "body" do
          expect(page).to have_content("#{@harvard.name} has #{@harvard.students.count} students.")
        end
      end

      it "has a link to the school's student listing" do
        visit "/schools/#{@harvard.id}"

        click_link("school-students-link")
        expect(page).to have_current_path("/schools/#{@harvard.id}/students")
      end

      it "has a link to update the school info" do
        visit "/schools/#{@harvard.id}"

        click_link("update-school-link")
        expect(page).to have_current_path("/schools/#{@harvard.id}/edit")
      end

      it "has a link to delete the school" do
        visit "/schools/#{@harvard.id}"

        expect(page.has_css?("#delete-school-link")).to eq(true)
      end

      it "can delete the school" do
        visit "/schools/#{@harvard.id}"

        find("#delete-school-link").click
        expect(page.current_path).to eq("/schools")

        expect(page).to_not have_content("Harvard University")
      end
    end

    describe "When I visit schools/:id/edit" do
      it "has a form to edit a school record" do
        visit "/schools/#{@harvard.id}/edit"

        within "body" do
          expect(page).to have_element("div", class: "form-description")
          expect(page).to have_element("form", id: "edit-school-form")
          expect(page).to have_element("input", id: "school-name")
          expect(page).to have_element("input", id: "school-location")
          expect(page).to have_element("input", id: "school-accredited")
          expect(page).to have_element("input", id: "school-capacity")
          expect(page).to have_element("input", type: "submit")
        end
      end

      it "can update a school record" do
        visit "/schools/#{@harvard.id}/edit"

        fill_in("school-name", with: "Harvard 2")
        fill_in("school-location", with: "Nowhereville")
        uncheck("school-accredited")
        fill_in("school-capacity", with: "100")

        find('input[type="submit"]').click

        expect(page.current_path).to eq("/schools/#{@harvard.id}")

        expect(page).to have_content("Harvard 2")
        expect(page).to have_content("no")
        expect(page).to have_content("Nowhereville")
        expect(page).to have_content("100")
      end
    end
  end

  describe "User story #5:" do
    describe "When I visit /schools/:school_id/students" do
      it "shows the students that belong to that school" do
        visit "/schools/#{@harvard.id}/students"

        within "body" do
          expect(page).to have_content("Aaron Aaronson")
          expect(page).to have_content("19")
          expect(page).to_not have_content("Henry Benry")
        end
      end
    end
  end

  describe "User story #11, #12:" do
    describe "When I visit the school creation page" do
      it "has a form for a new school record" do
        visit "/schools/new"

        within "body" do
          expect(page).to have_element("div", class: "form-description")
          expect(page).to have_element("form", id: "create-school-form")
          expect(page).to have_element("input", id: "school-name")
          expect(page).to have_element("input", id: "school-location")
          expect(page).to have_element("input", id: "school-accredited")
          expect(page).to have_element("input", id: "school-capacity")
          expect(page).to have_element("input", type: "submit")
        end
      end

      it "can create a new school record" do
        visit "/schools/new"

        fill_in("school-name", with: "Harvard 2")
        fill_in("school-location", with: "Nowhereville")
        uncheck("school-accredited")
        fill_in("school-capacity", with: "100")

        find('input[type="submit"]').click

        expect(page.current_path).to eq("/schools")

        expect(page).to have_content("Harvard 2")
        expect(page).to have_content("Nowhereville")
        expect(page).to have_content("100")
      end
    end
  end
end
