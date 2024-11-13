# frozen_string_literal: true

class AddIndexToActivitiesCreatedAt < ActiveRecord::Migration[8.0]
  def change
    add_index :activities, :created_at
  end
end
