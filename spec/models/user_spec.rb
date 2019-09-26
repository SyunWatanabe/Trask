# frozen_string_literal: true

require 'rails_helper'

describe User do
  it '有効なファクトリを持つ' do
    expect(FactoryBot.build(:user)).to be_valid
  end
  it '名前がなければ無効' do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
  end

  it '名前は10文字以内' do
    user = FactoryBot.build(:user, name: 'a' * 11)
    user.valid?
    expect(user.errors[:name]).to include('は10文字以内で入力してください')
  end

  it 'メールが無ければ無効' do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end

  it 'メールアドレスは255文字以内' do
    user = FactoryBot.build(:user, email: 'a' * 256)
    user.valid?
    expect(user.errors[:email]).to include('は255文字以内で入力してください')
  end
  it 'emailのバリデーションは正しく機能しているか' do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    addresses.each do |invalid_address|
      expect(FactoryBot.build(:user, email: invalid_address)).to be_invalid
    end
  end

  it '同じemailは無効' do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.build(:user, email: user1.email)
    user2.valid?
    expect(user2.errors[:email]).to include('はすでに存在します')
  end

  it 'パスワードが無ければ無効' do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include('を入力してください')
  end

  it '名前は6文字以上' do
    user = FactoryBot.build(:user, password: 'a' * 5)
    user.valid?
    expect(user.errors[:password]).to include('は6文字以上で入力してください')
  end
end
