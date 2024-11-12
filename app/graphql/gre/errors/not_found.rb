# frozen_string_literal: true

module Gre
  module Errors
    class NotFound < Types::BaseObject
      implements Interfaces::Error

      def self.code = 404
      def self.message = "Not found"
    end
  end
end
