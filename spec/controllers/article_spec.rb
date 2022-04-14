require 'rails_helper'

RSpec.describe ArticlesController do

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "produces an OK status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "GET show" do
    before(:each) do
      a = Article.create({title: "My Title", body: "This is a Body"})
      @id = a.id
    end

    it "renders the show template" do
      get :show, params: {id: @id}
      expect(response).to render_template("show")
    end

    it "produces an OK status code" do
      get :show, params: {id: @id}
      expect(response.status).to eq(200)
    end
  end
end
