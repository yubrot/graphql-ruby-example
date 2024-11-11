# frozen_string_literal: true

module Gre
  module Unions
    class BaseUnion < GraphQL::Schema::Union
      edge_type_class Types::BaseEdge
      connection_type_class Types::BaseConnection
    end
  end
end
