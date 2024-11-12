# frozen_string_literal: true

RSpec.describe Reaction do
  let(:reaction) { build_stubbed(:reaction) }

  describe "#anonymous?" do
    subject { reaction.anonymous? }

    context "when the reacted user exists" do
      it { is_expected.to be false }
    end

    context "when the reacted user missing" do
      let(:reaction) { build_stubbed(:reaction, :anonymous) }

      it { is_expected.to be true }
    end
  end
end
