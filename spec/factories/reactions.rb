# frozen_string_literal: true

FactoryBot.define do
  factory :reaction do
    association :activity
    association :reacted_user

    trait :anonymous do
      reacted_user { nil }
    end

    message { Faker::Color.color_name }
  end
end

# == Schema Information
#
# Table name: reactions
#
#  id              :integer          not null, primary key
#  activity_id     :integer          not null
#  reacted_user_id :integer
#  message         :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_reactions_on_activity_id      (activity_id)
#  index_reactions_on_reacted_user_id  (reacted_user_id)
#
