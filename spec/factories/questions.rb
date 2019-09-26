# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    user_id 1
    title 'テストタイトル'
    content 'テスト内容'
  end
end
