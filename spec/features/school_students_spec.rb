require "rails_helper"

RSpec.describe "Schools Web Pages", type: :feature do # rubocop:disable Metrics/BlockLength
  before(:each) do
    @harvard = School.create!(
      name: "Harvard University",
      location: "Cambridge, MA",
      abet_accredited: true,
      student_capacity: 22_000
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
  end

  describe "User story #13" do
    describe "when I visit /schools/:school_id/students" do
      it "has a link to create a new student for that school" do
        visit "/schools/#{@harvard.id}/students"

        click_link("add student")
        expect(page.current_path).to eq("/schools/#{@harvard.id}/students/new")
      end

      it "displays students in alphabetical order when link is clicked" do
        visit "/schools/#{@harvard.id}/students"

        expect(page.has_link?("alphabetize")).to eq(true)
        find_link("alphabetize").click

        within ".list" do
          expect(@aaron.name).to appear_before(@bill.name)
        end
      end

      it "can filter students by age" do
        visit "/schools/#{@harvard.id}/students"

        fill_in("age", with: "20")
        click_button("filter by age")
        expect(page.current_path).to eq("/schools/#{@harvard.id}/students")

        expect(page).to have_content("Aaron Aaronson")
        expect(page).to_not have_content("Bill Bobberson")
      end
    end

    describe "when I visit /schools/:school_id/students/new" do
      it "can create a new student for that school" do
        visit "/schools/#{@harvard.id}/students/new"

        fill_in("name", with: "Zed Zanders")
        fill_in("age", with: "105")
        fill_in("account_balance", with: "23.10")
        check("currently_enrolled")

        find_button("add student").click

        expect(page.current_path).to eq("/schools/#{@harvard.id}/students")

        expect(page).to have_content("Zed Zanders")
        expect(page).to have_content("105")
        expect(page).to have_content("23.10")
      end
    end
  end
end
