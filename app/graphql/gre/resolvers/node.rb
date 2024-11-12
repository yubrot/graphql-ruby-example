# frozen_string_literal: true

module Gre
  module Resolvers
    class Node < BaseResolver
      type Interfaces::Node, null: true

      argument :id, ID, required: true

      def resolve(id:) = context.schema.object_from_id(id, context)
    end
  end
end
