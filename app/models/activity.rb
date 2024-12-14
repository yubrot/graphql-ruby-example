# frozen_string_literal: true

class Activity < ApplicationRecord
  self.inheritance_column = :_type_disabled

  TYPES = {
    wakeup: "wakeup",
    breakfast: "breakfast",
    lunch: "lunch",
    dinner: "dinner",
    sleep: "sleep",
  }.freeze

  belongs_to :user

  has_many :reactions, dependent: :destroy

  enum :type, TYPES, prefix: true, validate: true

  def meal? = %w[breakfast lunch dinner].include? type

  # TODO: Add happened_at column, don't use created_at for business logic
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
