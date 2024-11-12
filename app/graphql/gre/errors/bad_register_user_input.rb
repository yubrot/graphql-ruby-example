# frozen_string_literal: true

module Gre
  module Errors
    class BadRegisterUserInput < Types::BaseObject
      implements Interfaces::Error

      field :name, [String], null: false, description: "List of errors for name."
      field :email, [String], null: false, description: "List of errors for email."

      def self.code = 400
      def self.message = "Bad input for registering a user"
    end
  end
end
