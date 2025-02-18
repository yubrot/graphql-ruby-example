# frozen_string_literal: true

module GraphqlMatchers
  class HaveGraphqlResponse
    include RSpec::Matchers
    include JsonExpressions::RSpec::Matchers

    def initialize(**data)
      @matcher = have_attributes(status: 200, parsed_body: match_json_expression(data:))
    end

    delegate :matches?, to: :@matcher

    delegate :failure_message, to: :@matcher
  end

  def have_graphql_response(...) = HaveGraphqlResponse.new(...)
end
