# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :answer_id, null: false
      t.integer :user_id, null: false

      t.timestamps

      t.index :user_id
      t.index :answer_id
      t.index %i[user_id answer_id], unique: true
    end
  end
end
