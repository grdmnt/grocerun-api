require "db"
require "pg"

module Infrastructure
  module Persistence
    abstract class Repository
      def initialize(@db : DB::Database)
      end

      protected def query(sql : String, *args)
        @db.query(sql, *args) do |rs|
          yield rs
        end
      end

      protected def query_one?(sql : String, *args)
        @db.query_one?(sql, *args) do |rs|
          yield rs
        end
      end

      protected def query_one(sql : String, *args)
        @db.query_one(sql, *args) do |rs|
          yield rs
        end
      end

      protected def execute(sql : String, *args)
        @db.exec(sql, *args) do |rs|
          yield rs
        end
      end

      protected def transaction
        @db.transaction do |tx|
          yield tx
        end
      end
    end
  end
end