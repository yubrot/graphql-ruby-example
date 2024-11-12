# frozen_string_literal: true

module Gre
  class Query < Types::BaseObject
    field :activities, resolver: Resolvers::Activities

    # TODO: replace them with node(id: ID!)

    field :activity, Types::Activity, null: true do
      argument :id, ID, required: true
    end
    field :user, Types::User, null: true do
      argument :id, ID, required: true
    end
    field :reaction, Types::Reaction, null: true do
      argument :id, ID, required: true
    end

    def activity(id:) = ::Activity.find_by(id:)
    def user(id:) = ::User.find_by(id:)
    def reaction(id:) = ::Reaction.find_by(id:)
  end
end
