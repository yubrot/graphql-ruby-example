# frozen_string_literal: true

RSpec.describe Gre::Mutations::RegisterUser, type: :request do
  subject do
    post("/graphql", params: { query:, variables: })
    response
  end

  let(:query) do
    <<~GRAPHQL
      mutation($input: RegisterUserInput!) {
        registerUser(input: $input) {
          __typename
          ... on Error {
            code
            message
          }
          ... on BadRegisterUserInput {
            name
            email
          }
          ... on User {
            id
            name
            email
          }
        }
      }
    GRAPHQL
  end
  let(:variables) { { input: } }

  context "when the input is valid" do
    let(:input) { { name: "Alice", email: "alice@example.com" } }

    it "creates a new user and returns it" do
      expect { subject }.to change(User, :count).by(1)
      expect(subject).to have_attributes(
        status: 200,
        parsed_body: match_json_expression(
          data: {
            registerUser: {
              __typename: "User",
              id: User.last.to_gid_param,
              name: "Alice",
              email: "alice@example.com",
            },
          },
        ),
      )
    end

    context "when the email has already been taken" do
      before { create(:user, email: "alice@example.com") }

      it "returns a conflict error" do
        expect { subject }.not_to change(User, :count)
        expect(subject).to have_attributes(
          status: 200,
          parsed_body: match_json_expression(
            data: {
              registerUser: {
                __typename: "Conflict",
                code: 409,
                message: "Conflict",
              },
            },
          ),
        )
      end
    end
  end

  context "when the input is invalid" do
    let(:input) { { name: "", email: "something" } }

    it "returns a bad input error" do
      expect { subject }.not_to change(User, :count)
      expect(subject).to have_attributes(
        status: 200,
        parsed_body: match_json_expression(
          data: {
            registerUser: {
              __typename: "BadRegisterUserInput",
              code: 400,
              message: "Bad input for registering a user",
              name: ["can't be blank"],
              email: ["is invalid"],
            },
          },
        ),
      )
    end
  end
end
