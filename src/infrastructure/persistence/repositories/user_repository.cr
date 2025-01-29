# src/infrastructure/persistence/repositories/user_repository.cr
module Infrastructure
  module Persistence
    module Repositories
      class UserRepository < Repository
        include Core::Repositories::UserRepository

        def find(id : UUID) : Core::Entities::User?
          sql = <<-SQL
            SELECT id, email, first_name, last_name, created_at, updated_at
            FROM users
            WHERE id = $1
          SQL

          query_one?(sql, id) do |rs|
            map_user(rs)
          end
        end

        def find_by_email(email : String) : Core::Entities::User?
          sql = <<-SQL
            SELECT id, email, first_name, last_name, created_at, updated_at
            FROM users
            WHERE email = $1
          SQL

          query_one?(sql, email) do |rs|
            map_user(rs)
          end
        end

        def create(user : Core::Entities::User) : Core::Entities::User
          sql = <<-SQL
            INSERT INTO users (id, email, first_name, last_name, created_at, updated_at)
            VALUES ($1, $2, $3, $4, $5, $6)
            RETURNING id, email, first_name, last_name, created_at, updated_at
          SQL

          query_one(sql, user.id, user.email, user.first_name, user.last_name, user.created_at, user.updated_at) do |rs|
            map_user(rs)
          end
        end

        def list(limit : Int32 = 20, offset : Int32 = 0) : Array(Core::Entities::User)
          sql = <<-SQL
            SELECT id, email, first_name, last_name, created_at, updated_at
            FROM users
            ORDER BY created_at DESC
            LIMIT $1 OFFSET $2
          SQL

          users = [] of Core::Entities::User
          query(sql, limit, offset) do |rs|
            rs.each do
              users << map_user(rs)
            end
          end
          users
        end

        private def map_user(rs : DB::ResultSet) : Core::Entities::User
          Core::Entities::User.new(
            id: rs.read(UUID),
            email: rs.read(String),
            first_name: rs.read(String),
            last_name: rs.read(String),
            created_at: rs.read(Time),
            updated_at: rs.read(Time)
          )
        end
      end
    end
  end
end