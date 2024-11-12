# frozen_string_literal: true

class CreateReactions < ActiveRecord::Migration[8.0]
  def change
    create_table :reactions do |t|
      t.references :activity, null: false, foreign_key: true
      t.references :reacted_user, foreign_key: { to_table: :users }
      t.string :message, null: false
      t.timestamps
    end
  end
end
