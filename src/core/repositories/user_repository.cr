module Core
  module Repositories
    module UserRepository
      abstract def find(id : UUID) : Entities::User?
      abstract def find_by_email(email : String) : Entities::User?
      abstract def create(user : Entities::User) : Entities::User
      abstract def list(limit : Int32, offset : Int32) : Array(Entities::User)
    end
  end
end
