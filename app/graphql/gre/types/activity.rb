# frozen_string_literal: true

module Gre
  module Types
    class Activity < BaseObject
      implements Interfaces::Node

      object_types << ::Activity

      field :type, Enums::ActivityTypeType, null: false
      field :memo, String, null: true
      field :user, Types::User, null: false
      field :reactions, [Types::Reaction], null: false
    end
  end
end
