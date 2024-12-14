# frozen_string_literal: true

RSpec.describe Reaction do
  let(:reaction) { build_stubbed.reaction }

  describe "#anonymous?" do
    subject { reaction.anonymous? }

    context "when the reacted user exists" do
      it { is_expected.to be false }
    end

    context "when the reacted user missing" do
      let(:reaction) { build_stubbed.reaction(:anonymous) }

      it { is_expected.to be true }
    end
  end
end

# == Schema Information
#
# Table name: reactions
#
#  id              :integer          not null, primary key
#  message         :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  activity_id     :integer          not null
#  reacted_user_id :integer
#
# Indexes
#
#  index_reactions_on_activity_id      (activity_id)
#  index_reactions_on_reacted_user_id  (reacted_user_id)
#
# Foreign Keys
#
#  activity_id      (activity_id => activities.id)
#  reacted_user_id  (reacted_user_id => users.id)
#
