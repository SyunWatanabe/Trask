class AddCategoryIdAndSubCategoryIdToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :category_id, :integer
    add_column :questions, :sub_category_id, :integer
    add_index :questions, [:category_id, :sub_category_id]
    add_index :questions, :sub_category_id
  end
end
