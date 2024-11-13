# frozen_string_literal: true

RSpec.describe Gre::Types::Reaction, type: :request do
  subject do
    post("/graphql", params: { query:, variables: })
    response
  end

  let(:query) do
    <<~GRAPHQL
      query($id: ID!) {
        node(id: $id) {
          ... on Reaction {
            message
            activity { id }
            reactedUser { id }
            isAnonymous
          }
        }
      }
    GRAPHQL
  end
  let(:variables) { { id: reaction.to_gid_param } }
  let(:reaction) { create(:reaction) }

  it "returns reaction data" do
    expect(subject).to have_attributes(
      status: 200,
      parsed_body: match_json_expression(
        data: {
          node: {
            message: reaction.message,
            activity: { id: reaction.activity.to_gid_param },
            reactedUser: { id: reaction.reacted_user.to_gid_param },
            isAnonymous: reaction.anonymous?,
          },
        },
      ),
    )
  end
end
