# frozen_string_literal: true

module Gre
  module Types
    class BaseObject < GraphQL::Schema::Object
      include Concerns::ObjectTypeRestriction
      include Concerns::CurrentUser

      edge_type_class Types::BaseEdge
      connection_type_class Types::BaseConnection
      field_class Types::BaseField

      def initialize(object, ...)
        self.class.accepts_object!(object)
        super
      end
    end
  end
end
