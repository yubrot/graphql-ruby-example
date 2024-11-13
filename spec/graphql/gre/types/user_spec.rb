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
            activities { edges { node { id } } }
            reactions { id }
          }
        }
      }
    GRAPHQL
  end
  let(:variables) { { id: user.to_gid_param } }
  letbp(:context, %i[user activities another_user_activities]) do
    let.user do
      let.activities = [activity, activity]
    end
    user do
      let.another_user_activities = [
        activity { reaction(reacted_user: ref.user) },
        activity { reaction(reacted_user: ref.user) },
      ]
    end
  end

  it "returns user data" do
    expect(subject).to have_attributes(
      status: 200,
      parsed_body: match_json_expression(
        data: {
          node: {
            name: user.name,
            email: user.email,
            activities: {
              edges: activities.map { { node: { id: _1.to_gid_param } } },
            },
            reactions: another_user_activities.map { { id: _1.reactions[0].to_gid_param } },
          },
        },
      ),
    )
  end
end
