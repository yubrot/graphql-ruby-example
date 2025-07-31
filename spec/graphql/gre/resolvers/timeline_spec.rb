# frozen_string_literal: true

RSpec.describe Gre::Resolvers::Timeline, type: :request do
  subject do
    post("/graphql", params: { query:, variables: })
    response
  end

  let(:query) do
    <<~GRAPHQL
      query {
        timeline {
          nodes {
            id
          }
        }
      }
    GRAPHQL
  end
  let(:variables) { nil }
  let(:activities) { create_list(:activity, 3) }

  before { activities }

  it "returns the list of all activities" do
    expect(subject).to have_graphql_response(
      timeline: {
        nodes: activities.sort_by(&:created_at).map { { id: it.to_gid_param } },
      },
    )
  end
end
