# frozen_string_literal: true

class AddAnswersCountToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :answers_count, :integer, null: false, default: 0
  end
end
