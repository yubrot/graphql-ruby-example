# frozen_string_literal: true

RSpec.describe Gre::Resolvers::Node, type: :request do
  subject do
    post("/graphql", params: { query:, variables: })
    response
  end

  let(:query) do
    <<~GRAPHQL
      query($id: ID!) {
        node(id: $id) {
          id
          __typename
        }
      }
    GRAPHQL
  end
  let(:variables) { { id: } }

  context "when the object associated with the id does not exist" do
    let(:id) { build_stubbed(:user).to_gid_param }

    it "returns null" do
      expect(subject).to have_graphql_response(node: nil)
    end
  end

  context "when the object associated with the id exists" do
    let(:id) { create(:user).to_gid_param }

    it "returns the object" do
      expect(subject).to have_graphql_response(node: { __typename: "User", id: })
    end
  end
end
