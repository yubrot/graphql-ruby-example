# frozen_string_literal: true

RSpec.describe Gre::Types::Activity, type: :request do
  subject do
    post("/graphql", params: { query:, variables: })
    response
  end

  let(:query) do
    <<~GRAPHQL
      query($id: ID!) {
        node(id: $id) {
          ... on Activity {
            type
            memo
            user { id }
            reactions { id }
            isMeal
          }
        }
      }
    GRAPHQL
  end
  let(:variables) { { id: activity.to_gid_param } }
  letbp(:activity, %i[reactions]) do
    activity do
      let.reactions = [reaction, reaction]
    end
  end

  it "returns activity data" do
    expect(subject).to have_graphql_response(
      node: {
        type: activity.type.upcase,
        memo: activity.memo,
        user: { id: activity.user.to_gid_param },
        reactions: activity.reactions.map { { id: _1.to_gid_param } },
        isMeal: activity.meal?,
      },
    )
  end
end
