# frozen_string_literal: true

module Gre
  class Schema < GraphQL::Schema
    mutation Mutation
    query Query

    # For batch-loading (see https://graphql-ruby.org/dataloader/overview.html)
    use GraphQL::Dataloader

    disable_introspection_entry_points if Rails.env.production?

    max_depth 15
    max_complexity 999_999_999
    max_query_string_tokens 5000
    validate_max_errors 100
    default_max_page_size 50

    # Union and Interface Resolution
    def self.resolve_type(abstract_type, obj, _ctx)
      possible_types = possible_types(abstract_type)
      possible_types = FieldError.filter_types(possible_types, obj)
      possible_types = Concerns::ObjectTypeRestriction.filter_types(possible_types, obj)
      possible_types.sole
    rescue Enumerable::SoleItemExpectedError
      nil
    end

    # Handle a raised FieldError as a GraphQL response
    rescue_from(FieldError) { |err, _, _, _, _| err }

    # Relay-style Object Identification:

    def self.id_from_object(object, _type_definition, _query_ctx)
      object.to_gid_param
    end

    def self.object_from_id(global_id, _query_ctx)
      GlobalID::Locator.locate(global_id)
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end
end
