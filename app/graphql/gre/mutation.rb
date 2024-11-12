# frozen_string_literal: true

module Gre
  class Mutation < Types::BaseObject
    field :register_user, mutation: Mutations::RegisterUser
  end
end
