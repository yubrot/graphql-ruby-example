# frozen_string_literal: true

module Gre
  module Resolvers
    class Activities < BaseResolver
      type Types::Activity.connection_type, null: false

      def resolve = ::Activity.all
    end
  end
end
