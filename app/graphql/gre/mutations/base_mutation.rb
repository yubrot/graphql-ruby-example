# frozen_string_literal: true

module Gre
  module Mutations
    class BaseMutation < GraphQL::Schema::RelayClassicMutation
      argument_class Types::BaseArgument
      field_class Types::BaseField
      input_object_class Inputs::BaseInput
      object_class Types::BaseObject
    end
  end
end
