# frozen_string_literal: true

RSpec.describe Gre::Types::User, type: :request do
  subject do
    post("/graphql", params: { query:, variables: })
    response
  end

  let(:query) do
    <<~GRAPHQL
      query($id: ID!) {
        node(id: $id) {
          ... on User {
            name
            email
            activities { nodes { id } }
            reactions { id }
          }
        }
      }
    GRAPHQL
  end
  let(:variables) { { id: user.to_gid_param } }
  let(:user) { create.user(with_pair.activity) }
  let(:reactions) { create_pair.reaction(reacted_user: user) }

  before { reactions }

  it "returns user data" do
    expect(subject).to have_graphql_response(
      node: {
        name: user.name,
        email: user.email,
        activities: {
          nodes: user.activities.map { { id: _1.to_gid_param } },
        },
        reactions: reactions.map { { id: _1.to_gid_param } },
      },
    )
  end
end
