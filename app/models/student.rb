class Student < ApplicationRecord
  belongs_to :school

  def self.alphabetical
    Student.order("name ASC")
  end

  def self.enrolled
    Student.where("currently_enrolled = ?", true)
  end
end
