# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


20.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password(8),
    city: ["San Francisco", "New York", "Chicago"].sample,
    graduation_date: Faker::Date.between(6.months.ago, Date.today)
  )
end

100.times do
  Lead.create(
    user_id: rand(1..20),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    company: Faker::Company.name,
    linkedin_url: Faker::Internet.url,
    email_sent: false,
    meeting_set: false,
    interview_set: false,
    job_offer: false
  )
end