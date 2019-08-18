require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  scenario "ユーザー1がユーザー2の回答にコメントする" do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    question = FactoryBot.create(:question, user_id: user1.id)
    answer = FactoryBot.create(:answer, user_id: user2.id, question_id: question.id)

    sign_in(user1)

    expect {
      click_link "Questions"
      within(".questions") do
        click_link "テストタイトル"
      end
      click_link "comment"
      fill_in "comment", with: "テストコメント"
      click_button "コメント"
      expect(page).to have_content "コメントしました！！"
      expect(page).to have_content "テストコメント"
    }.to change(user1.comments, :count).by(1)
  end
end
