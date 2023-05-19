# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

gender = %w[female male other]
created_date = Date.today - 1.year
20.times do
  date = created_date + rand(1..365).days

  user = User.create(name: FFaker::Name.name, age: rand(15..99), gender: gender.sample,
                     created_at: date)
  user.build_account(email: FFaker::Internet.email, password: '77938719Vanya', role: 'regular', created_at: date).save if user.persisted?
end
