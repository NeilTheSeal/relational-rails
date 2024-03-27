require "rails_helper"

RSpec.describe School do
  it { should have_many :students }

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

  describe "initialization" do
    it "has expected attributes" do
      expect(@aaron.name).to eq("Aaron Aaronson")
      expect(@aaron.age).to eq(21)
      expect(@aaron.currently_enrolled).to eq(true)
      expect(@aaron.account_balance).to eq(0)
    end
  end

  describe "filter students by enrollment" do
    it "filters students by enrollment" do
      expect(Student.enrolled.to_a).to eq([
        @bill, @aaron, @dan, @frodo, @evan, @henry
      ])
    end
  end

  describe "alphabetize students" do
    it "orders students alphabetically" do
      expect(Student.alphabetical.to_a).to eq([
        @aaron, @bill, @chase, @dan, @evan, @frodo, @gilbert, @henry
      ])
    end
  end
end
