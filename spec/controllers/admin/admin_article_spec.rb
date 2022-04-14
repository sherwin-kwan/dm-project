require 'rails_helper'

RSpec.describe Admin::ArticlesController do

  before(:each) do
    a = Article.create({title: "Sample Title", body: "This is a Body"})
    @id = a.id
  end

  describe "index" do
    it "renders the index template with the right status code" do
      get :index
      expect(response).to render_template("index")
      expect(response.status).to eq(200)
    end
  end

  describe "new" do
    it "renders the new template with the right status code" do
      get :new
      expect(response).to render_template("new")
      expect(response.status).to eq(200)
    end
  end

  describe "create" do
    it "should fail if you try to create articles without a title" do
      post :create, params: {article: {title: ""}}
      expect(Article.count).to eq(1)
      expect(response.status).to eq(400)
    end

    it "should show a relevant error message" do 
      post :create, params: {article: {title: ""}}
      expect(flash[:errors]).to include("could not be created")
    end

    it "should create a new article if everything's filled out" do
      post :create, params: {article: {title: "New Title", body: "My Body"}}
      expect(response).to redirect_to(admin_articles_path)
      expect(Article.find_by(title: "New Title")).to be_truthy
    end
  end

  describe "edit" do
    it "renders the edit template with the right status code" do
      get :edit, params: {id: @id}
      expect(response).to render_template("edit")
      expect(response.status).to eq(200)
    end
  end

  describe "update" do
    it "should fail if you try to update articles to drop the title" do
      put :update, params: {id: @id, article: {title: ""}}
      expect(response.status).to eq(400)
    end

    it "should show a relevant error message" do 
      put :update, params: {id: @id, article: {title: ""}}
      expect(flash[:errors]).to include("could not be updated")
    end

    it "should update the article if everything's filled out" do
      put :update, params: {id: @id, article: {title: "You Didn't Expect This, Did You?", body: "My Body"}}
      expect(response).to redirect_to(admin_articles_path)
      expect(Article.find(@id).title).to eq("You Didn't Expect This, Did You?")
    end
  end

  describe "destroy" do
    it "should destroy an article" do
      delete :destroy, params: {id: @id}
      expect{ Article.find(@id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end