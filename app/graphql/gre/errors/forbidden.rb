# frozen_string_literal: true

module Gre
  module Errors
    class Forbidden < Types::BaseObject
      implements Interfaces::Error

      def self.code = 403
      def self.message = "Forbidden"
    end
  end
end
