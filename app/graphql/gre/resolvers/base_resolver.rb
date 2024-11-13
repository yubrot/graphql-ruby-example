# frozen_string_literal: true

module Gre
  module Resolvers
    class BaseResolver < GraphQL::Schema::Resolver
      include Concerns::InlineUnionTypes
      include Concerns::CurrentUser
    end
  end
end
