# frozen_string_literal: true

class Activity < ApplicationRecord
  self.inheritance_column = :_type_disabled

  TYPES = {
    wakeup: "wakeup",
    breakfast: "breakfast",
    lunch: "lunch",
    dinner: "dinner",
    sleep: "sleep"
  }.freeze

  belongs_to :user

  has_many :reactions, dependent: :destroy

  enum :type, TYPES, prefix: true, validate: true

  def meal? = %w[breakfast lunch dinner].include? type
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
