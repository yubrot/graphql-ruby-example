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
      end

      # @param obj [Object]
      def type_check_object!(obj)
        return if self.class.object_types.empty? || self.class.object_types.any? { obj.is_a? it }

        raise ArgumentError, "Unexpected object type #{obj.class} for schema type #{self.class}"
      end

      class << self
        # Filter the possible schema types based on object type restrictions.
        # @param possible_types [Array<Class<GraphQL::Schema::Member>>]
        # @param obj [Object]
        # @return [Array<Class<GraphQL::Schema::Member>>]
        def filter_types(possible_types, obj)
          matched_possible_types = possible_types.filter do |ty|
            ty.include?(self) && ty.object_types.any? { obj.is_a? it }
          end
          matched_possible_types.presence ||
            # There are no matched types, but at least we can reject types that have explicit object_types.
            possible_types.reject do |ty|
              ty.include?(self) && ty.object_types.present?
            end
        end
      end
    end
  end
end
