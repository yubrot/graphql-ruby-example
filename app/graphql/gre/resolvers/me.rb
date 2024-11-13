# frozen_string_literal: true

module Gre
  module Resolvers
    class Me < BaseResolver
      type Types::User, null: true

      def resolve = current_user
    end
  end
end
