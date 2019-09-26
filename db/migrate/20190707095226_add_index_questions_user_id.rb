# frozen_string_literal: true

class AddIndexQuestionsUserId < ActiveRecord::Migration[5.2]
  def change
    add_index :questions, :user_id
  end
end
