# src/web/routes/health_routes.cr
module Web
  module Routes
    class HealthRoutes
      def self.setup
        get "/health" do |env|
          env.response.content_type = "application/json"
          {status: "ok", version: GrocerunApi::VERSION}.to_json
        end
      end
    end
  end
end
