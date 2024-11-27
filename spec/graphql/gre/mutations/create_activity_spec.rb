# frozen_string_literal: true

RSpec.describe Gre::Mutations::CreateActivity, type: :request do
  subject do
    post("/graphql", params: { query:, variables: }, headers:)
    response
  end

  let(:query) do
    <<~GRAPHQL
      mutation($input: CreateActivityInput!) {
        createActivity(input: $input) {
          __typename
          ... on Activity {
            id
            memo
            reactions { id }
            type
            user { id }
          }
          ... on Error {
            code
            message
          }
        }
      }
    GRAPHQL
  end
  let(:variables) { { input: } }
  let(:headers) { {} }
  let(:input) { { type: "WAKEUP", memo: "at 08:00" } }

  context "when the user is authorized" do
    let(:headers) { { "X-User-Email" => "alice@example.com" } }
    let(:user) { create.user(email: "alice@example.com") }

    before { user }

    it "creates an activity for the user" do
      expect { subject }.to change(Activity, :count).by(1)
      expect(subject).to have_graphql_response(
        createActivity: {
          __typename: "Activity",
          id: Activity.last.to_gid_param,
          memo: "at 08:00",
          reactions: [],
          type: "WAKEUP",
          user: { id: user.to_gid_param },
        },
      )
    end
  end

  context "when the user is not authorized" do
    it "returns a forbidden error" do
      expect { subject }.not_to change(Activity, :count)
      expect(subject).to have_graphql_response(
        createActivity: {
          __typename: "Forbidden",
          code: 403,
          message: "User authorization required",
        },
      )
    end
  end
end
