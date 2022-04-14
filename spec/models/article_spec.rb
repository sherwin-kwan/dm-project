require 'rails_helper'

RSpec.describe Article, type: :model do
  it "shouldn't let you save an article with no title" do
    a = Article.new({title: "", body: "This is a body"})
    expect(a.save).to be(false)
    expect(Article.count).to eq(0)
  end

  it "should NOT let us create an article with no body" do
    a = Article.new({title: "This is a title", body: ""})
    expect(a.save).to be(false)
    expect(Article.count).to eq(0)
  end

  it "should ALLOW us to create an article with a title and a body" do
    a = Article.new({ title: "My title", body: "The body of the article" })
    expect(a.save).to be(true)
    expect(Article.count).to eq(1)
  end
end
