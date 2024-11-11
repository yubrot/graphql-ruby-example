# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true do
      argument :id, ID, required: true
    end

    field :nodes, [Types::NodeType, { null: true }], null: true do
      argument :ids, [ID], required: true
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    def test_field
      "Hello World!"
    end
  end
end
