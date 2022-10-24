require 'rails_helper'

RSpec.describe User, type: :model do
  it "can create users" do
    u = User.create(email: "aabc@def.com", password: "abcdefgh", password_confirmation: "abcdefgh")
    expect(User.count).to eq(1)
  end

  it "won't create user if password doesn't match confirmation" do
    u = User.create(email: "aabc@def.com", password: "abcdefgh", password_confirmation: "abcdefhg")
    expect(u.valid?).to be(false)
  end

  it "won't create user if the password is shorter than 8 characters" do
    u = User.create(email: "aabc@def.com", password: "abcdefg", password_confirmation: "abcdefg")
    expect(u.valid?).to be(false)
  end

  it "password isn't saved as plaintext" do
    u = User.create(email: "aabc@def.com", password: "abcdefgh", password_confirmation: "abcdefgh")
    expect(User.first.password_digest.include?("abcdefgh")).to be(false)
  end

  it "doesn't let you use a fake email" do
    u = User.create(email: "asd.fasdfasdfasdf.com", password: "abcdefgh", password_confirmation: "abcdefgh")
    expect(u.valid?).to be(false)
  end

  it "doesn't let you use a fake email (2)" do
    u = User.create(email: "asd.fasdfasdfasdf@omnomnom", password: "abcdefgh", password_confirmation: "abcdefgh")
    expect(u.valid?).to be(false)
  end

  it "lets you use special characters in a password" do
    u = User.create(email: "abc@def.com", password: "道可道非常道❌✅", password_confirmation: "道可道非常道❌✅")
    expect(u.valid?).to be(true)
  end
end 