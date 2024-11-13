# frozen_string_literal: true

module Gre
  module Concerns
    # Shorthand for context[:current_user]. See /app/controllers/graphql_controller.rb
    module CurrentUser
      def current_user
        context[:current_user]
      end

      def current_user!
        current_user or raise FieldError.forbidden("User authorization required")
      end
    end
  end
end
