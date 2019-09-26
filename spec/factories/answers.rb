# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    user_id 1
    question_id 1
    reply 'テスト返信'
  end
end
