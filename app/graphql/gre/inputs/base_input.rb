# frozen_string_literal: true

module Gre
  module Inputs
    class BaseInput < GraphQL::Schema::InputObject
      argument_class Types::BaseArgument
    end
  end
end
