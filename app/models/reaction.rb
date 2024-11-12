# frozen_string_literal: true

class Reaction < ApplicationRecord
  belongs_to :activity
  belongs_to :reacted_user, class_name: "User", optional: true

  validates :message, presence: true

  def anonymous? = reacted_user_id.nil?
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
