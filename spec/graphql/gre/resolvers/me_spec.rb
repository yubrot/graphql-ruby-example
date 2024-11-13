# frozen_string_literal: true

RSpec.describe Gre::Resolvers::Me, type: :request do
  subject do
    post("/graphql", params: { query: }, headers:)
    response
  end

  let(:query) do
    <<~GRAPHQL
      query {
        me { id }
      }
    GRAPHQL
  end
  let(:headers) { {} }

  context "when the user is authorized" do
    let(:headers) { { "X-User-Email" => "alice@example.com" } }
    let(:user) { create(:user, email: "alice@example.com") }

    before { user }

    it "returns the user" do
      expect(subject).to have_graphql_response(me: { id: user.to_gid_param })
    end
  end

  context "when the user is not authorized" do
    it "returns null" do
      expect(subject).to have_graphql_response(me: nil)
    end
  end
end
