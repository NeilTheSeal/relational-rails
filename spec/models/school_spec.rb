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
end
