require 'rails_helper'

RSpec.describe Article, type: :model do

  let(:a) { FactoryBot.build(:article, title: "", body: "This is a body") }
  let(:b) { FactoryBot.build(:article, title: "This is a title", body: "") }
  let(:c) { FactoryBot.build(:article, title: "This is a title", body: "And a body!") }


  it "shouldn't let you save an article with no title" do
    expect(a.save).to be(false)
    expect(Article.count).to eq(0)
  end

  it "should NOT let us create an article with no body" do
    expect(b.save).to be(false)
    expect(Article.count).to eq(0)
  end

  it "should ALLOW us to create an article with a title and a body" do
    expect(c.save).to be(true)
    expect(Article.count).to eq(1)
  end
end
