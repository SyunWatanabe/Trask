# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it '有効なファクトリを持つ' do
    expect(FactoryBot.build(:comment)).to be_valid
  end

  it 'ユーザーIDが無ければ無効' do
    comment = FactoryBot.build(:comment, user_id: nil)
    comment.valid?
    expect(comment.errors[:user_id]).to include('を入力してください')
  end

  it '回答IDが無ければ無効' do
    comment = FactoryBot.build(:comment, answer_id: nil)
    comment.valid?
    expect(comment.errors[:answer_id]).to include('を入力してください')
  end

  it 'コメントが無ければ無効' do
    comment = FactoryBot.build(:comment, content: nil)
    comment.valid?
    expect(comment.errors[:content]).to include('を入力してください')
  end

  it 'コメントは40文字以内' do
    comment = FactoryBot.build(:comment, content: 'a' * 41)
    comment.valid?
    expect(comment.errors[:content]).to include('は40文字以内で入力してください')
  end
end
