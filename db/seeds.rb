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
bill = harvard.students.create!(
  name: "Bill Bobberson",
  age: 19,
  account_balance: -200,
  currently_enrolled: true
)
aaron = harvard.students.create!(
  name: "Aaron Aaronson",
  age: 21,
  account_balance: 0,
  currently_enrolled: true
)
evan = cu.students.create!(
  name: "Evan Evanston",
  age: 22,
  account_balance: -2000,
  currently_enrolled: true
)
chase = mit.students.create!(
  name: "Chase McChase",
  age: 25,
  account_balance: 0,
  currently_enrolled: false
)
dan = mit.students.create!(
  name: "Daniel O'Daniel",
  age: 35,
  account_balance: 25_000,
  currently_enrolled: true
)
henry = party.students.create!(
  name: "Henry Benry",
  age: 18,
  account_balance: 50,
  currently_enrolled: true
)
gilbert = party.students.create!(
  name: "Gilbert Gottfried",
  age: 67,
  account_balance: 0,
  currently_enrolled: false
)
frodo = cu.students.create!(
  name: "Frodo Baggins",
  age: 50,
  account_balance: 200_000,
  currently_enrolled: true
)
