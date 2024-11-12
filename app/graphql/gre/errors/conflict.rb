# frozen_string_literal: true

module Gre
  module Errors
    class Conflict < Types::BaseObject
      implements Interfaces::Error

      def self.code = 409
      def self.message = "Conflict"
    end
  end
end
