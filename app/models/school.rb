class School < ApplicationRecord
  has_many :students

  def self.chronological
    order("created_at DESC")
  end
end
