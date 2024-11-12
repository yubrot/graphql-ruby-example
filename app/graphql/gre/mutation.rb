# frozen_string_literal: true

module Gre
  class Mutation < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false
    def test_field
      "Hello World"
    end
  end
end
