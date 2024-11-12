# frozen_string_literal: true

module Gre
  module Concerns
    # This module provides a way to restrict object types that can be used as a resolver result.
    # This information can also be used to resolve the schema type of the resolver results.
    module ObjectTypeRestriction
      extend ActiveSupport::Concern

      class_methods do
        def object_types
          @object_types ||= []
        end
      end

      # @param obj [Object]
      def type_check_object!(obj)
        return if self.class.object_types.empty? || self.class.object_types.any? { obj.is_a? _1 }

        raise ArgumentError, "Unexpected object type #{obj.class} for schema type #{self.class}"
      end

      class << self
        # Resolve a schema type by object type restrictions.
        # @param possible_types [Array<Class<GraphQL::Schema::Member>>]
        # @param obj [Object]
        def resolve_type(possible_types, obj)
          possible_types
            .filter { |ty| ty.include?(self) && ty.object_types.any? { obj.is_a? _1 } }
            .sole
        rescue Enumerable::SoleItemExpectedError
          nil
        end
      end
    end
  end
end
