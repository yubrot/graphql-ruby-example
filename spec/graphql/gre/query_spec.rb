# frozen_string_literal: true

RSpec.describe Gre::Query, type: :request do
  subject do
    post("/graphql", params: { query: })
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
end
