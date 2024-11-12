# frozen_string_literal: true

RSpec.describe Activity do
  let(:activity) { build_stubbed(:activity, type:) }

  describe "#meal?" do
    subject { activity.meal? }

    context "when the type of activity is a meal" do
      let(:type) { %w[breakfast lunch dinner].sample }

      it { is_expected.to be true }
    end

    context "when the type of activity is not a meal" do
      let(:type) { %w[wakeup sleep].sample }

      it { is_expected.to be false }
    end
  end
end
