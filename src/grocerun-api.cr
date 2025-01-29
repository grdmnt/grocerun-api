require "kemal"

# Crystal UUID
require "uuid"

# Core layer
require "./core/entities/**"
require "./core/repositories/**"
require "./core/use_cases/**"
require "./core/jobs/**"

# Infrastructure layer
require "./infrastructure/persistence/**"
require "./infrastructure/workers/**"
require "./infrastructure/queue/**"
require "./infrastructure/external_services/**"

# Interface layer
require "./interfaces/controllers/**"
require "./interfaces/presenters/**"
require "./interfaces/serializers/**"

# Web layer
require "./web/routes/**"
require "./web/middlewares/**"

# Shared utilities
require "./shared/**"

require "./application"

module GrocerunApi
  VERSION = "0.1.0"

  app = Grocerun::Application.instance

  # Setup routes
  Web::Routes::HealthRoutes.setup

  # Configure Kemal
  Kemal.config.env = "development" # or get from ENV
  Kemal.config.port = 3000         # or get from ENV

  if PROGRAM_NAME.ends_with?("grocerun-api")
    Kemal.run
  end
end
