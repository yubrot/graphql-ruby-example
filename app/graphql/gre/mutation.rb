# frozen_string_literal: true

module Gre
  class Mutation < Types::BaseObject
    field :register_user, mutation: Mutations::RegisterUser
    field :create_activity, mutation: Mutations::CreateActivity
  end
end
