# frozen_string_literal: true

module Gre
  module Types
    class User < BaseObject
      implements Interfaces::Node

      object_types ::User

      field :name, String, null: false
      field :email, String, null: false
      field :activities, Types::Activity.connection_type, null: false
      field :reactions, [Types::Reaction], null: false
    end
  end
end
