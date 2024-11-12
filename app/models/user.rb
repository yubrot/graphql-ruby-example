# frozen_string_literal: true

class User < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_many :reactions, inverse_of: :reacted_user, dependent: :nullify

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
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
