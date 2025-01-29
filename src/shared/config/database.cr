# src/shared/config/database.cr
module Shared
  module Config
    class Database
      getter database : String
      getter hostname : String
      getter port : Int32
      getter username : String
      getter password : String

      def initialize(@database, @hostname, @port, @username, @password)
      end

      def self.load(environment : String = ENV.fetch("CRYSTAL_ENV", "development")) : self
        case environment
        when "development"
          new(
            database: "grocerun_development",
            hostname: "localhost",
            port: 5432,
            username: "postgres",
            password: "postgres"
          )
        when "test"
          new(
            database: "grocerun_test",
            hostname: "localhost",
            port: 5432,
            username: "postgres",
            password: "postgres"
          )
        when "production"
          new(
            database: ENV.fetch("DB_NAME"),
            hostname: ENV.fetch("DB_HOST"),
            port: ENV.fetch("DB_PORT").to_i,
            username: ENV.fetch("DB_USER"),
            password: ENV.fetch("DB_PASSWORD")
          )
        else
          raise "Unknown environment: #{environment}"
        end
      end

      def self.connection_url : String
        config = load
        "postgres://#{config.username}:#{config.password}@#{config.hostname}:#{config.port}/#{config.database}"
      end
    end
  end
end