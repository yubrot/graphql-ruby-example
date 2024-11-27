# frozen_string_literal: true

RSpec.describe Gre::Mutations::ReactToActivity, type: :request do
  subject do
    post("/graphql", params: { query:, variables: }, headers:)
    response
  end

  let(:query) do
    <<~GRAPHQL
      mutation($input: ReactToActivityInput!) {
        reactToActivity(input: $input) {
          __typename
          ... on Reaction {
            id
            message
            reactedUser { id }
            activity { id }
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
  let(:input) { { activityId: activity.to_gid_param, message: "hi" } }

  context "when the activity exists" do
    let(:activity) { create.activity }

    context "when the user is authorized" do
      let(:headers) { { "X-User-Email" => "alice@example.com" } }
      let(:user) { create.user(email: "alice@example.com") }

      before { user }

      it "creates a reaction to the activity with the user association" do
        expect { subject }.to change(Reaction, :count).by(1)
        expect(subject).to have_graphql_response(
          reactToActivity: {
            __typename: "Reaction",
            id: Reaction.last.to_gid_param,
            message: "hi",
            reactedUser: { id: user.to_gid_param },
            activity: { id: activity.to_gid_param },
          },
        )
      end
    end

    context "when the user is not authorized" do
      it "creates a reaction to the activity without user association" do
        expect { subject }.to change(Reaction, :count).by(1)
        expect(subject).to have_graphql_response(
          reactToActivity: {
            __typename: "Reaction",
            id: Reaction.last.to_gid_param,
            message: "hi",
            reactedUser: nil,
            activity: { id: activity.to_gid_param },
          },
        )
      end
    end

    context "when the input is invalid" do
      let(:input) { { activityId: activity.to_gid_param, message: "" } }

      it "returns a bad request error" do
        expect { subject }.not_to change(Reaction, :count)
        expect(subject).to have_graphql_response(
          reactToActivity: {
            __typename: "BadRequest",
            code: 400,
            message: "Bad request",
          },
        )
      end
    end
  end

  context "when the activity does not exist" do
    let(:activity) { build_stubbed.activity }

    it "returns a not found error" do
      expect { subject }.not_to change(Reaction, :count)
      expect(subject).to have_graphql_response(
        reactToActivity: {
          __typename: "NotFound",
          code: 404,
          message: "Not found",
        },
      )
    end
  end
end
