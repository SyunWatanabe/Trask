# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Answers', type: :feature do
  scenario 'ユーザー2がユーザー1の質問に回答する' do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    question = FactoryBot.create(:question, user_id: user1.id)

    sign_in(user1)

    # ユーザー1がログアウトする
    click_link 'Account'
    click_link 'Logout'
    expect(page).to have_content 'ログアウトしました！'

    sign_in(user2)

    expect do
      click_link 'Questions'
      within('.questions') do
        click_link 'テストタイトル'
      end
      click_button '質問に回答する'
      expect(page).to have_content '回答'
      fill_in 'answer_reply', with: 'テスト回答'
      click_button '回答する'
      expect(page).to have_content '回答しました！！'
      within('.a') do
        expect(page).to have_content 'テストタイトル'
      end
      within('.reply') do
        expect(page).to have_content 'テスト回答'
      end
      expect(page).to have_content user1.name && user2.name
    end.to change(user2.answers, :count).by(1)
  end
end
