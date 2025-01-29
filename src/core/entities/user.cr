module Core
  module Entities
    class User
        getter id : UUID?
        getter email : String
        getter first_name : String
        getter last_name : String
        getter created_at : Time
        getter updated_at : Time

        def initialize(
          @email : String,
          @first_name : String,
          @last_name : String,
          @id : UUID? = UUID.v7,
          @created_at : Time = Time.utc,
          @updated_at : Time = Time.utc
        )
        end
    end
  end
end