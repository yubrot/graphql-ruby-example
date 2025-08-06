# frozen_string_literal: true

module Gre
  module Concerns
    # This module provides a way to restrict object types that can be used as a resolver result.
    # This information can also be used to filter the possible types.
    module ObjectTypeRestriction
      extend ActiveSupport::Concern

      class_methods do
        def object_types(*types)
          @object_types ||= []
          @object_types.concat(types)
        end

        def accepts_object?(obj)
          object_types.empty? || object_types.any? { obj.is_a? it }
        end

        def accepts_object!(obj)
          accepts_object?(obj) or raise ArgumentError, "Unexpected object type #{obj.class} for schema type #{self}"
        end
      end

      class << self
        # Filter the possible schema types based on object type restrictions.
        # @param possible_types [Array<Class<GraphQL::Schema::Member>>]
        # @param obj [Object]
        # @return [Array<Class<GraphQL::Schema::Member>>]
        def filter_types(possible_types, obj)
          restricted_types, free_types = possible_types.partition { it.include?(self) && it.object_types.present? }
          # If there is no matched type, at least we can reject restricted types.
          restricted_types.filter { it.accepts_object?(obj) }.presence || free_types
        end
      end
    end
  end
end
