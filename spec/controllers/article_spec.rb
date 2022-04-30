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
      get "/articles/#{@a.id}"
      expect(response).to render_template("show")
    end

    it "produces an OK status code" do
      get "/articles/#{@a.id}"
      expect(response.status).to eq(200)
    end

    it "can access an article by title" do
      get "/articles/sample_title"
      expect(response).to render_template("show")
    end
  end

end
