# frozen_string_literal: true

module Gre
  module Resolvers
    class BaseResolver < GraphQL::Schema::Resolver
      include Concerns::InlineUnionTypes
    end
  end
end
