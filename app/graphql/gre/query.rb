# frozen_string_literal: true

module Gre
  class Query < Types::BaseObject
    field :activities, resolver: Resolvers::Activities
    field :node, resolver: Resolvers::Node
  end
end
