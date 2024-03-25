require "rails_helper"

RSpec.describe School do
  it { should have_many :students }

  describe "initialization" do
    before(:each) do
      @harvard = School.create!(
        name: "Harvard University",
        location: "Cambridge, MA",
        abet_accredited: true,
        student_capacity: 22_000
      )
    end

    it "has expected attributes" do
      expect(@harvard.name).to eq("Harvard University")
      expect(@harvard.location).to eq("Cambridge, MA")
      expect(@harvard.abet_accredited).to eq(true)
      expect(@harvard.student_capacity).to eq(22_000)
    end
  end

  describe "order schools by created_at" do
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
    end

    it "orders schools in descending order by date created" do
      expect(School.chronological.to_a).to eq([@mit, @harvard])
    end
  end
end
