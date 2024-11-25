# frozen_string_literal: true

RSpec.describe "factories" do # rubocop:disable RSpec/DescribeClass
  subject { FactoryBot.lint traits: true }

  it "passes the FactoryBot.lint" do
    expect { subject }.not_to raise_error
  end
end
