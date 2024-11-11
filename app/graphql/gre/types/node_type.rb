# frozen_string_literal: true

module Gre
  module Types
    module NodeType
      include Interfaces::BaseInterface
      # Add the `id` field
      include GraphQL::Types::Relay::NodeBehaviors
    end
  end
end
