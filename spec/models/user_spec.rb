require 'rails_helper'

describe User do
  it "is valid with a name, email, and password" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is invalid without a name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "is invalid with name length grater than 10"
  it { is_expected.to validates_length_of :name, minimum:10 }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it "is invalid with a duplicate email address"
end
