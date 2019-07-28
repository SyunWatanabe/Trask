class AddRepictureToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :repicture, :string
  end
end
