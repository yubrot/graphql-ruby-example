# frozen_string_literal: true

module GraphqlMatchers
  class HaveGraphqlResponse
    include RSpec::Matchers
    include JsonExpressions::RSpec::Matchers

    def initialize(**data)
      @matcher = have_attributes(status: 200, parsed_body: match_json_expression(data:))
    end

    def matches?(actual) = @matcher.matches? actual

    def failure_message = @matcher.failure_message
  end

  def have_graphql_response(...) = HaveGraphqlResponse.new(...)
end
