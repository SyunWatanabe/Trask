# frozen_string_literal: true

class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :user_id, :integer, default: 0, null: false
  end
end
