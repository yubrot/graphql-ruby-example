# frozen_string_literal: true

module GraphqlMatchers
  class HaveGraphqlResponse
    include RSpec::Matchers
    include JsonExpressions::RSpec::Matchers

    def initialize(**expected_data)
      @expected_data = expected_data
    end

    def matches?(response)
      unless response.is_a?(ActionDispatch::TestResponse)
        return failure_with_message do
          <<~MESSAGE
            expected: ActionDispatch::TestResponse
                 got: #{RSpec::Support::ObjectFormatter.format(response)}
          MESSAGE
        end
      end

      response_sig = [response.status, response.headers["Content-Type"]]
      unless response_sig in [200, %r{^application/json}] | [_, %r{^application/graphql-response\+json}]
        return failure_with_message do
          pretty_response_body =
            begin
              JSON.pretty_generate(JSON.parse(response.body))
            rescue JSON::ParserError
              response.body
            end
          <<~MESSAGE
            expected: GraphQL HTTP response
                 got: HTTP #{response.status} response
            response body:
            #{pretty_response_body}
          MESSAGE
        end
      end

      data_matcher = match_json_expression(data: @expected_data)
      data_matcher.matches?(JSON.parse(response.body)) ||
        failure_with_message do
          <<~MESSAGE
            GraphQL response data does not match;
            #{data_matcher.failure_message}
          MESSAGE
        end
    end

    def failure_message = @failure_message_handler.call

    private

    def failure_with_message(&block)
      @failure_message_handler = block
      false
    end
  end

  def have_graphql_response(...) = HaveGraphqlResponse.new(...)
end
