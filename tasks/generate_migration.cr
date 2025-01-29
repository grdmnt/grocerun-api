require "micrate"
require "file_utils"

name = ARGV[0]?
if name.nil?
  puts "Please provide a migration name"
  puts "Example: crystal tasks/generate_migration.cr create_users"
  exit 1
end

timestamp = Time.utc.to_s("%Y%m%d%H%M%S")
filename = "#{timestamp}_#{name}.sql"
path = File.join("db", "migrations", filename)

FileUtils.mkdir_p("db/migrations")

File.write(path, <<-SQL
-- +micrate Up
-- SQL for migrating up goes here


-- +micrate Down
-- SQL for migrating down goes here

SQL
)

puts "Created migration: #{path}"
