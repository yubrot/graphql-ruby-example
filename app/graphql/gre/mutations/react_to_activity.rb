# frozen_string_literal: true

module Gre
  module Mutations
    class ReactToActivity < BaseMutation
      possible_types Types::Reaction, Errors::NotFound, Errors::BadRequest, null: false

      argument :activity_id, ID, required: true
      argument :message, String, required: true

      def resolve(activity_id:, message:)
        activity = Schema.object_from_id!(activity_id, context, only: ::Activity)
        activity.reactions.create!(reacted_user: current_user, message:)
      rescue ActiveRecord::RecordNotFound
        raise FieldError.not_found
      rescue ActiveRecord::RecordInvalid
        raise FieldError.bad_request
      end
    end
  end
end
