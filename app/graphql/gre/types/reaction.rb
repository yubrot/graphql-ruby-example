# frozen_string_literal: true

module Gre
  module Types
    class Reaction < BaseObject
      implements Interfaces::Node

      object_types ::Reaction

      field :message, String, null: false
      field :activity, Types::Activity, null: false
      field :reacted_user, Types::User, null: true
      field :is_anonymous, Boolean, null: false, method: :anonymous?
    end
  end
end
