# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Likes', type: :feature do
  scenario 'ユーザー1がユーザー2の回答にいいねON、いいねOFFする' do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    question = FactoryBot.create(:question, user_id: user1.id)
    answer = FactoryBot.create(:answer, user_id: user2.id, question_id: question.id)

    sign_in(user1)

    expect do
      click_link 'Questions'
      within('.questions') do
        click_link 'テストタイトル'
      end
      click_button
    end.to change(answer.likes, :count).by(1)

    expect do
      click_button
    end.to change(answer.likes, :count).by(-1)
  end
end
