class AddIndexQuestionsCreatedAt < ActiveRecord::Migration[5.2]
  def change
    add_index :questions, :created_at
  end
end
