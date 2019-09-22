class CreateSubCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_categories do |t|
      t.string :name,null: false
      t.integer :category_id, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
