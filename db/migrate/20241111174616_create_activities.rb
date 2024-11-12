# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :type, null: false
      t.string :memo
      t.timestamps
    end
  end
end
