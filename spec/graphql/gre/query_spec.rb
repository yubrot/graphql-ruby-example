# frozen_string_literal: true

RSpec.describe Gre::Query, type: :request do
  subject do
    post("/graphql", params: { query:, variables: })
    response
  end

  describe "activities field" do
    let(:query) do
      <<~GRAPHQL
        query {
          activities {
            edges {
              node {
                id
              }
            }
          }
        }
      GRAPHQL
    end
    let(:variables) { nil }
    let(:activities) { create_list(:activity, 3) }

    before { activities }

    it "returns the list of all activities" do
      expect(subject).to have_attributes(
        status: 200,
        parsed_body: match_json_expression(
          data: {
            activities: {
              edges: activities.map { { node: { id: _1.to_gid_param } } }
            }
          },
        ),
      )
    end
  end

  describe "node field" do
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
        expect(subject).to have_attributes(
          status: 200,
          parsed_body: match_json_expression(data: { node: nil }),
        )
      end
    end

    context "when the object associated with the id exists" do
      let(:id) { create(:user).to_gid_param }

      it "returns the object" do
        expect(subject).to have_attributes(
          status: 200,
          parsed_body: match_json_expression(data: { node: { __typename: "User", id: } }),
        )
      end
    end
  end
end
