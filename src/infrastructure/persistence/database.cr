# src/infrastructure/persistence/database.cr
require "db"
require "pg"

module Infrastructure
  module Persistence
    class Database
      @@instance : DB::Database?

      def self.connection
        @@instance ||= DB.open(connection_url)
      end

      private def self.connection_url
        Shared::Config::Database.connection_url
      end
    end
  end
end
