# frozen_string_literal: true

module Gre
  module Errors
    class BadRequest < Types::BaseObject
      implements Interfaces::Error

      def self.code = 400
      def self.message = "Bad request"
    end
  end
end
