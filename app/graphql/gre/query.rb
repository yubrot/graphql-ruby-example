# frozen_string_literal: true

module Gre
  class Query < Types::BaseObject
    field :timeline, resolver: Resolvers::Timeline
    field :node, resolver: Resolvers::Node
    field :me, resolver: Resolvers::Me
  end
end
