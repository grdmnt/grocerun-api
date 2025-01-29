require "micrate"
require "pg"
require "../src/shared/config/database"

# Load database configuration
Micrate::DB.connection_url = Shared::Config::Database.connection_url

# Execute micrate commands
Micrate::Cli.run