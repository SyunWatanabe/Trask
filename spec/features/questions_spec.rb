# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Questions', type: :feature do
  scenario 'ユーザーが質問する' do
    user = FactoryBot.create(:user)
    sign_in(user)

    expect do
      click_link 'Questions'
      click_link 'ログインして質問する！！'
      fill_in 'question_title', with: 'テストタイトル'
      fill_in 'question_content', with: 'テスト内容'
      click_button '質問投稿'

      expect(page).to have_content '質問を投稿しました！！'
      expect(page).to have_content 'テストタイトル'
      expect(page).to have_content 'テスト内容'
      expect(page).to have_content user.name
    end.to change(user.questions, :count).by(1)
  end
end
