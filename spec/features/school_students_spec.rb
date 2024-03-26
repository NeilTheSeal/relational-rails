require "rails_helper"

RSpec.describe "Schools Web Pages", type: :feature do # rubocop:disable Metrics/BlockLength
  describe "User story #13" do
    describe "when I visit /schools/:school_id/students" do
      before(:each) do
        @harvard = School.create!(
          name: "Harvard University",
          location: "Cambridge, MA",
          abet_accredited: true,
          student_capacity: 22_000
        )
      end

      it "has a link to create a new student for that school" do
        visit "/schools/#{@harvard.id}/students"

        click_link "add student"
        expect(page.current_path).to eq("/schools/#{@harvard.id}/students/new")
      end
    end

    describe "when I visit /schools/:school_id/students/new" do
      before(:each) do
        @harvard = School.create!(
          name: "Harvard University",
          location: "Cambridge, MA",
          abet_accredited: true,
          student_capacity: 22_000
        )
        @aaron = @harvard.students.create!(
          name: "Aaron Aaronson",
          age: 21,
          account_balance: 0,
          currently_enrolled: true
        )
      end
      it "can create a new student for that school" do
        visit "/schools/#{@harvard.id}/students/new"

        fill_in("student-name", with: "Zed Zanders")
        fill_in("student-age", with: "105")
        fill_in("student-balance", with: "23.10")
        check("student-enrolled")

        find('input[type="submit"]').click

        expect(page.current_path).to eq("/schools/#{@harvard.id}/students")

        expect(page).to have_content("Zed Zanders")
        expect(page).to have_content("105")
        expect(page).to have_content("23.10")
      end
    end
  end
end
