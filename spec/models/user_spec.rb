# frozen_string_literal: true

RSpec.describe User do
  describe "#destroy" do
    subject { user.destroy! }

    let(:user) { create.user(with.activity(:wakeup, with.reaction(:anonymous)), with.activity(:sleep)) }
    let(:reaction) { create.reaction(reacted_user: user) }

    it "destroys all activities of the user and converts all reactions to anonymous ones" do
      expect { subject }.to(
        change(Activity, :count).by(-2)
        .and(change { reaction.reload.reacted_user }.from(user).to(nil)),
      )
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
