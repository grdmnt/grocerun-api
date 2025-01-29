module Grocerun
  class Application
    getter db : DB::Database
    getter user_repository : Infrastructure::Persistence::Repositories::UserRepository
    getter user_use_case : Core::UseCases::UserUseCase

    def initialize
      @db = Infrastructure::Persistence::Database.connection
      @user_repository = Infrastructure::Persistence::Repositories::UserRepository.new(@db)
      @user_use_case = Core::UseCases::UserUseCase.new(@user_repository)
    end

    def self.instance
      @@instance ||= new
    end
  end
end