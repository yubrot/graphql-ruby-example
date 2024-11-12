# frozen_string_literal: true

module Gre
  module Unions
    class RegisterUserResult < BaseUnion
      possible_types Types::User, Errors::BadRegisterUserInput, Errors::Conflict
    end
  end
end
