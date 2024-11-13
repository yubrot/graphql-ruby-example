# frozen_string_literal: true

module Gre
  module Resolvers
    class Timeline < BaseResolver
      type Types::Activity.connection_type, null: false

      def resolve = ::Activity.order(created_at: :desc)
    end
  end
end
