# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  it '有効なファクトリを持つ' do
    expect(FactoryBot.build(:like)).to be_valid
  end

  it 'ユーザーIDが無ければ無効' do
    like = FactoryBot.build(:like, user_id: nil)
    like.valid?
    expect(like.errors[:user_id]).to include('を入力してください')
  end

  it '回答IDが無ければ無効' do
    like = FactoryBot.build(:like, answer_id: nil)
    like.valid?
    expect(like.errors[:answer_id]).to include('を入力してください')
  end
end
