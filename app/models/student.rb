class Student < ApplicationRecord
  belongs_to :school

  def self.alphabetical
    Student.order(name, :asc)
  end
end
