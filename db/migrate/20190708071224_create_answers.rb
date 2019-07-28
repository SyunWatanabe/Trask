class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :reply
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
    add_index :answers, [:user_id, :question_id, :created_at]
  end
end
