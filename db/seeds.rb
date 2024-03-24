# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
harvard = School.create!(
  name: "Harvard University",
  location: "Cambridge, MA",
  abet_accredited: true,
  student_capacity: 22_000
)
mit = School.create!(
  name: "Massachusetts Institute of Technology",
  location: "Cambridge, MA",
  abet_accredited: true,
  student_capacity: 12_000
)
cu = School.create!(
  name: "University of Colorado, Boulder",
  location: "Boulder, CO",
  abet_accredited: true,
  student_capacity: 38_000
)
party = School.create!(
  name: "Party University",
  location: "Tijuana, Mexico",
  abet_accredited: false,
  student_capacity: 100_000
)
