# frozen_string_literal: true

RSpec.describe User do
  describe "#destroy" do
    subject { user.destroy! }

    letbp(:context, %i[user another_user reaction]) do
      let.user do
        activity(:wakeup) { reaction(:anonymous) }
        activity(:sleep)
      end
      let.another_user = user do
        activity(:lunch) { let.reaction(reacted_user: ref.user) }
      end
    end

    it "destroys all activities of the user and converts all reactions to anonymous ones" do
      expect { subject }.to(
        change(Activity, :count).by(-2)
        .and(change { reaction.reload.reacted_user }.from(user).to(nil)),
      )
    end
  end
end
