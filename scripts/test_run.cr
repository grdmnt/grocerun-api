# scripts/console.cr
require "../src/grocerun-api"

db = Infrastructure::Persistence::Database.connection

# Initialize repository
user_repository = Infrastructure::Persistence::Repositories::UserRepository.new(db)

# Initialize use case
user_use_case = Core::UseCases::UserUseCase.new(user_repository)

# Test creating a user
begin
  user = user_use_case.create_user(
    email: "john@example.com",
    first_name: "John",
    last_name: "Doe"
  )
  puts "Created user: #{user.inspect}"
rescue ex : Core::UseCases::UserUseCase::EmailTakenError
  puts "Error: #{ex.message}"
end

# Test finding a user
if user = user_repository.find_by_email("john@example.com")
  puts "Found user: #{user.inspect}"
else
  puts "User not found"
end

# List users
users = user_repository.list(limit: 10)
puts "\nListing users:"
users.each do |user|
  puts "- #{user.first_name} #{user.last_name} (#{user.email})"
end
