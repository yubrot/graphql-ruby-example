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
#  user_id    :integer          not null
#  type       :string           not null
#  memo       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_activities_on_user_id  (user_id)
#
