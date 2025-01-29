module Core
  module UseCases
    class UserUseCase
      class EmailTakenError < Exception; end

      def initialize(@repository : Core::Repositories::UserRepository)
      end

      def create_user(email : String, first_name : String, last_name : String) : Entities::User
        if @repository.find_by_email(email)
          raise EmailTakenError.new("Email already taken")
        end

        user = Entities::User.new(
          email: email.downcase.strip,
          first_name: first_name.strip,
          last_name: last_name.strip,
        )

        @repository.create(user)
      end

      def find_user(id : UUID) : Entities::User?
        @repository.find(id)
      end

      def list_users(page : Int32 = 1, per_page : Int32 = 20) : Array(Entities::User)
        offset = (page - 1) * per_page
        @repository.list(per_page, offset)
      end
    end
  end
end
