# frozen_string_literal: true

module Gre
  module Concerns
    # This module introduces a `#possible_types` helper, which can be used in the place of `#type`
    # to describe union possible types inline.
    module InlineUnionTypes
      extend ActiveSupport::Concern

      class_methods do
        def possible_types(*types, **options)
          case types.size
          when 0
            raise ArgumentError, "At least one type is required"
          when 1
            type(types.first, **options)
          else
            type(generate_union_type(types), **options)
          end
        end

        def generate_union_type(types)
          union_graphql_name = "#{graphql_name}Result"

          Class.new(Unions::BaseUnion) do
            @_union_graphql_name = union_graphql_name

            def self.default_graphql_name = @_union_graphql_name

            possible_types(*types)
          end
        end
      end
    end
  end
end
