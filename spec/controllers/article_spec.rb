require 'rails_helper'

RSpec.describe "Articles Controller", :type => :request do

  describe "GET index" do
    it "renders the index template" do
      get "/"
      expect(response).to render_template("index")
    end

    it "produces an OK status code" do
      get "/"
      expect(response.status).to eq(200)
    end
  end

  describe "GET show" do
    before(:each) do
      @a = FactoryBot.create(:article, title: "Sample Title")
    end

    it "renders the show template" do
      get "/articles/#{@a.id}-#{@a.slug}"
      expect(response).to render_template("show")
    end

    it "produces an OK status code" do
      get "/articles/#{@a.id}-#{@a.slug}"
      expect(response.status).to eq(200)
    end

    it "can access an article by title" do
      get "/articles/#{@a.id}-sample-title"
      expect(response).to render_template("show")
    end

    it "URL changes after the title changes" do
      @a.title = "New Title"
      @a.save
      get "/articles/#{@a.id}-new-title"
      expect(response).to render_template("show")
    end

    it "the old URL still works, but redirects to the new URL" do
      @a.title = "New Title"
      @a.save
      get "/articles/#{@a.id}-sample-title"
      expect(response.status).to eq(302)
      expect(response).to redirect_to("/articles/#{@a.id}-new-title")
    end
  end

end
