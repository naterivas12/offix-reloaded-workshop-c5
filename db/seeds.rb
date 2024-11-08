require "faker"

puts "Start seeding data"

# Departments
puts "Seeding departments"
Department.destroy_all

marketing = Department.new(
  name: "Marketing",
  description: Faker::Lorem.paragraph,
)
cover_url = Faker::LoremFlickr.image(size: "500x600", search_terms: ['office']) # http://flickerlrem...
marketing.cover.attach(io: URI.open(cover_url), filename: "marketing.jpg")
puts marketing.errors.full_messages unless marketing.save

engineering = Department.new(
  name: "Engineering",
  description: Faker::Lorem.paragraph,
)
cover_url = Faker::LoremFlickr.image(size: "500x600", search_terms: ['office'])
engineering.cover.attach(io: URI.open(cover_url), filename: "engineering.jpg")
puts engineering.errors.full_messages unless engineering.save

operations = Department.new(
  name: "Operations",
  description: Faker::Lorem.paragraph,
)
cover_url = Faker::LoremFlickr.image(size: "500x600", search_terms: ['office'])
operations.cover.attach(io: URI.open(cover_url), filename: "operations.jpg")
puts operations.errors.full_messages unless operations.save

# Employees
puts "Seeding employees"
Employee.destroy_all

10.times do |n|
  name = Faker::Name.name
  employee = [marketing, engineering, operations].sample.employees.new(
    name: name,
    nationality: Faker::Nation.nationality,
    email: Faker::Internet.safe_email(name: name),
    position: Faker::Job.title,
    birth_date: Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
    password: "letmein"
  )
  avatar_url = Faker::Avatar.image
  employee.avatar.attach(io: URI.open(avatar_url), filename: "employee-#{n}.jpg")
  puts employee.errors.full_messages unless employee.save
end


admin = engineering.employees.new(
  name: "Admin",
  nationality: Faker::Nation.nationality,
  email: "admin@mail.com",
  position: "Administrator",
  birth_date: Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
  password: "letmein",
  role: "admin"
)
avatar_url = Faker::Avatar.image
admin.avatar.attach(io: URI.open(avatar_url), filename: "admin.jpg")
puts admin.errors.full_messages unless admin.save