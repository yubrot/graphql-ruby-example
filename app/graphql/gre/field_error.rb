# frozen_string_literal: true

module Gre
  # Errors occurred during resolving fields.
  class FieldError < StandardError
    # @param error_type [Class<Interfaces::Error>] GraphQL object type that implements Interfaces::Error interface
    # @param details [Hash] Error details conforms to error_type
    def initialize(error_type, **details)
      unless error_type < Types::BaseObject && error_type.implements.any? { _1.abstract_type == Interfaces::Error }
        raise ArgumentError, "error_type must be a GraphQL object type that implements Interfaces::Error interface"
      end
      unless error_type.respond_to?(:code) && error_type.respond_to?(:message)
        raise ArgumentError, "error_type must provide .code and .message"
      end

      super(details.delete(:message) || error_type.message)

      @_error_type = error_type
      @_details = details
    end

    # We use `_` prefix to avoid conflict with field resolvers.
    attr_reader :_error_type, :_details

    # NOTE: Since Exception implements #message, we don't need to reimplement it.
    delegate :code, to: :@_error_type

    # Resolvers for fields other than `code` and `message` are provided through method_missing.
    def method_missing(name) = @_details.fetch(name) { super }

    def respond_to_missing?(name, ...) = @_details.key?(name)

    class << self
      # Filter the possible schema types based on error handling assumption.
      # Assumption: Always use FieldError when returning errors.
      # @param possible_types [Array<Class<GraphQL::Schema::Member>>]
      # @param obj [Object]
      # @return [Array<Class<GraphQL::Schema::Member>>]
      def filter_types(possible_types, obj)
        # When obj is a FieldError, obj knows what the error type is.
        # Returns it after verifying that it conforms to the schema.
        # NOTE: Since this filter does not require the above assumption, this filter is basically safe.
        if obj.is_a?(FieldError)
          error_type = obj._error_type
          raise "Unexpected error #{error_type}" unless possible_types.include?(error_type)

          return [error_type]
        end

        # Otherwise, we can exclude error types (types that implements Interfaces::Error).
        # NOTE: This filter requires the above assumption.
        possible_types.reject do |ty|
          ty.implements.any? { _1.abstract_type == Interfaces::Error }
        end
      end

      def bad_request(message = nil) = new(Errors::BadRequest, message:)

      def forbidden(message = nil) = new(Errors::Forbidden, message:)

      def not_found(message = nil) = new(Errors::NotFound, message:)

      def conflict(message = nil) = new(Errors::Conflict, message:)
    end
  end
end
