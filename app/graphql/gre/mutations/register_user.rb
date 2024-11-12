# frozen_string_literal: true

module Gre
  module Mutations
    class RegisterUser < BaseMutation
      type Unions::RegisterUserResult, null: false

      argument :name, String, required: true
      argument :email, String, required: true

      def resolve(name:, email:)
        user = ::User.new(name:, email:)
        user.save!
        user
      rescue ActiveRecord::RecordNotUnique
        raise FieldError.conflict
      rescue ActiveRecord::RecordInvalid
        raise FieldError.new(
          Errors::BadRegisterUserInput,
          name: user.errors.messages[:name] || [],
          email: user.errors.messages[:email] || [],
        )
      end
    end
  end
end