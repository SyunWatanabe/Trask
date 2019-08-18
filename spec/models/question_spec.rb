require 'rails_helper'

RSpec.describe Question, type: :model do
  it "有効なファクトリを持つ" do
    expect(FactoryBot.build(:question)).to be_valid
  end

  it "質問タイトルが無ければ無効" do
    question = FactoryBot.build(:question, title: nil)
    question.valid?
    expect(question.errors[:title]).to include("を入力してください")
  end

  it "質問タイトルは25文字以内" do
    question = FactoryBot.build(:question, title: "a" * 26)
    question.valid?
    expect(question.errors[:title]).to include("は25文字以内で入力してください")
  end

  it "質問内容が無ければ無効" do
    question = FactoryBot.build(:question, content: nil)
    question.valid?
    expect(question.errors[:content]).to include("を入力してください")
  end

  it "質問内容は500文字以内" do
    question = FactoryBot.build(:question, content: "a" * 501)
    question.valid?
    expect(question.errors[:content]).to include("は500文字以内で入力してください")
  end
  it "ユーザーIDが無ければ無効" do
    question = FactoryBot.build(:question, user_id: nil)
    question.valid?
    expect(question.errors[:user_id]).to include("を入力してください")
  end
end
