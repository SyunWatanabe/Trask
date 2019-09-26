# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  it '有効なファクトリを持つ' do
    expect(FactoryBot.build(:answer)).to be_valid
  end

  it 'ユーザーIDが無ければ無効' do
    answer = FactoryBot.build(:answer, user_id: nil)
    answer.valid?
    expect(answer.errors[:user_id]).to include('を入力してください')
  end

  it '質問IDが無ければ無効' do
    answer = FactoryBot.build(:answer, question_id: nil)
    answer.valid?
    expect(answer.errors[:question_id]).to include('を入力してください')
  end

  it '返信内容が無ければ無効' do
    answer = FactoryBot.build(:answer, reply: nil)
    answer.valid?
    expect(answer.errors[:reply]).to include('を入力してください')
  end

  it '返信内容は500文字以内' do
    answer = FactoryBot.build(:answer, reply: 'a' * 501)
    answer.valid?
    expect(answer.errors[:reply]).to include('は500文字以内で入力してください')
  end
end
