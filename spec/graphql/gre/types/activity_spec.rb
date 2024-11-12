# frozen_string_literal: true

RSpec.describe Gre::Types::Activity, type: :request do
  subject do
    post("/graphql", params: { query:, variables: })
    response
  end

  let(:query) do
    <<~GRAPHQL
      query($id: ID!) {
        activity(id: $id) {
          id
          type
          memo
          user { id }
          reactions { id }
        }
      }
    GRAPHQL
  end
  let(:variables) { { id: activity.id.to_s } }
  letbp(:activity, %i[reactions]) do
    activity do
      let.reactions = [reaction, reaction]
    end
  end

  it "returns activity data" do
    expect(subject).to have_attributes(
      status: 200,
      parsed_body: match_json_expression(
        data: {
          activity: {
            id: activity.to_gid_param,
            type: activity.type.upcase,
            memo: activity.memo,
            user: { id: activity.user.to_gid_param },
            reactions: activity.reactions.map { { id: _1.to_gid_param } }
          }
        },
      ),
    )
  end
end
