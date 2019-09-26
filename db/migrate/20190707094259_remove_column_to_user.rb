# frozen_string_literal: true

class RemoveColumnToUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :user_id, :integer, index: true
  end
end
