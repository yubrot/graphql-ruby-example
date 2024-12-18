# frozen_string_literal: true

FactoryBot.define do
  factory :activity do
    association :user

    Activity::TYPES.each do |type, value|
      trait type do
        type { value }
      end
    end

    type { Activity::TYPES.values.sample }
  end
end

# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  memo       :string
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_activities_on_created_at  (created_at)
#  index_activities_on_user_id     (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
