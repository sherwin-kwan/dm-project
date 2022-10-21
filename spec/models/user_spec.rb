require 'rails_helper'

RSpec.describe User, type: :model do
  it "can create users" do
    u = FactoryBot.create(:user)
    expect(User.count).to eq(1)
  end

  it "won't let you create a duplicate email" do
    u = FactoryBot.create(:user)
    expect{ FactoryBot.create(:user)}.to raise_error(ActiveRecord::RecordInvalid)
    expect(User.count).to eq(1)
  end

  it "won't create user if password doesn't match confirmation" do
    expect{ FactoryBot.create(:user, password: "abcdefgh", password_confirmation: "abcdefhg") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "won't create user if the password is shorter than 8 characters" do
    expect{ FactoryBot.create(:user, password: "abcdefg", password_confirmation: "abcdefg") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "password isn't saved as plaintext" do
    u = FactoryBot.create(:user)
    expect(User.first.password_digest.include?("abcdefgh")).to be(false)
  end

  it "doesn't let you use a fake email" do
    expect{ FactoryBot.create(:user, email: "asd.fwefasfwaefawef.com") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "doesn't let you use a fake email (2)" do
    expect { FactoryBot.create(:user, email: "asd.fasdfasdfasdf@omnomnom") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "lets you use special characters in a password" do
    u = FactoryBot.create(:user, password: "道可道非常道❌✅", password_confirmation: "道可道非常道❌✅")
    expect(u.valid?).to be(true)
  end
end 