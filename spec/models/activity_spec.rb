# frozen_string_literal: true

RSpec.describe Activity do
  let(:activity) { build_stubbed.activity(type:) }

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

# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  type       :string           not null
#  memo       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_activities_on_created_at  (created_at)
#  index_activities_on_user_id     (user_id)
#
