require 'rails_helper'

RSpec.describe "Admin Articles controller", type: :request do
  let(:a) {
    FactoryBot.create(:article)
  }

  describe "index" do
    it "renders the index template with the right status code" do
      get "/admin/articles"
      expect(response).to render_template("index")
      expect(response.status).to eq(200)
    end
  end

  describe "new" do
    it "renders the new template with the right status code" do
      get "/admin/articles/new"
      expect(response).to render_template("new")
      expect(response.status).to eq(200)
    end
  end

  describe "create" do
    it "should fail if you try to create articles without a title" do
      post "/admin/articles", params: {article: {title: ""}}
      expect(Article.count).to eq(0)
      expect(response.status).to eq(400)
    end

    it "should show a relevant error message" do 
      post "/admin/articles", params: {article: {title: ""}}
      expect(flash[:errors]).to include("could not be created")
    end

    it "should create a new article if everything's filled out" do
      post "/admin/articles", params: {article: {title: "New Title", body: "My Body"}}
      expect(response).to redirect_to(admin_articles_path)
      expect(Article.find_by(title: "New Title")).to be_truthy
    end
  end

  describe "edit" do
    it "renders the edit template with the right status code" do
      get "/admin/articles/#{a.id}/edit"
      expect(response).to render_template("edit")
      expect(response.status).to eq(200)
    end

    it "renders the edit template if slug is passed instead of ID" do
      get "/admin/articles/#{a.id}-#{a.slug}/edit"
      expect(response).to render_template("edit")
      expect(response.status).to eq(200)
    end
  end

  describe "update" do
    it "should fail if you try to update articles to drop the title" do
      put "/admin/articles/#{a.id}", params: {id: a.id, article: {title: ""}}
      expect(response.status).to eq(400)
    end

    it "should show a relevant error message" do 
      put "/admin/articles/#{a.id}", params: {id: a.id, article: {title: ""}}
      expect(flash[:errors]).to include("could not be updated")
    end

    it "should update the article if everything's filled out" do
      put "/admin/articles/#{a.id}", params: {id: a.id, article: {title: "You Didn't Expect This, Did You?", body: "My Body"}}
      expect(response).to redirect_to(admin_articles_path)
      expect(Article.find(a.id).title).to eq("You Didn't Expect This, Did You?")
    end

    it "should update the article if everything's filled out, and slug is passed" do
      put "/admin/articles/#{a.id}-#{a.slug}", params: {id: a.id, article: {title: "You Didn't Expect This, Did You?", body: "My Body"}}
      expect(response).to redirect_to(admin_articles_path)
      expect(Article.find(a.id).title).to eq("You Didn't Expect This, Did You?")
    end
  end

  describe "destroy" do
    it "should destroy an article" do
      delete "/admin/articles/#{a.id}", params: {id: a.id}
      expect{ Article.find(a.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should be able to destroy by slug" do
      delete "/admin/articles/#{a.id}-#{a.slug}"
      expect{ Article.find(a.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end