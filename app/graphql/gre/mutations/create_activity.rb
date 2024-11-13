# frozen_string_literal: true

module Gre
  module Mutations
    class CreateActivity < BaseMutation
      possible_types Types::Activity, Errors::Forbidden, null: false

      argument :type, Enums::ActivityTypeType, required: true
      argument :memo, String, required: false

      def resolve(type:, memo: nil)
        current_user!.activities.create!(type:, memo:)
      end
    end
  end
end
