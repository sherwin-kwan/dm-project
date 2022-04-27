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
    let(:a) {
      FactoryBot.create(:article)
    }

    it "renders the show template" do
      get :show, params: {id: a.id}
      expect(response).to render_template("show")
    end

    it "produces an OK status code" do
      get :show, params: {id: a.id}
      expect(response.status).to eq(200)
    end
  end
end
