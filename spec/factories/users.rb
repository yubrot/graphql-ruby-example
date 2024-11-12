# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:reacted_user] do
    name { Faker::Name.name }
    email { Faker::Internet.email(name:, separators: ["-"]) }
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
