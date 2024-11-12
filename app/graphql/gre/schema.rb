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
      Concerns::ObjectTypeRestriction.resolve_type(possible_types(abstract_type), obj)
    end

    # Relay-style Object Identification:

    # Return a string UUID for `object`
    def self.id_from_object(object, _type_definition, _query_ctx)
      # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
      object.to_gid_param
    end

    # Given a string UUID, find the object
    def self.object_from_id(global_id, _query_ctx)
      # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
      GlobalID::Locator.locate(global_id)
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end
end
