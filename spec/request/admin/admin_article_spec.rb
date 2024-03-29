require 'rails_helper'

RSpec.describe "Admin Articles controller", type: :request do
  let(:a) {
    FactoryBot.create(:article)
  }

  context "when not signed in" do
    it "cannot hit any admin endpoints" do
      get "/admin/articles"
      expect(response.status).to eq(302)
      expect(response).to redirect_to("/users/login")
    end

    it "cannot create articles without logging in" do
      post "/admin/articles", params: {article: {title: ""}}
      expect(response.status).to eq(302)
      expect(response).to redirect_to("/users/login")
    end

    it "cannot edit articles without logging in" do
      put "/admin/articles/#{a.id}", params: {id: a.id, article: {title: ""}}
      expect(response.status).to eq(302)
      expect(response).to redirect_to("/users/login")
    end

    it "cannot delete articles without logging in" do
      delete "/admin/articles/#{a.id}", params: {id: a.id}
      expect(response.status).to eq(302)
      expect(response).to redirect_to("/users/login")
    end
  end

  context "when signed in" do

    before(:all) do
      @p = FactoryBot.create(:person)
      @u = @p.user
      post "/users/login", params: {email: @u.email, password: @u.password}
    end

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

      it "should sanitize contents before saving to db" do
        post "/admin/articles", params: {article: {title: "Some Title", body: "Muhahaha <script>alert('Malicious code')</script>"}}
        expect(Article.find_by(title: "Some Title").body).to_not include("<script>")
      end
      
      it "even if script tags get into the db, it still shouldn't render onto the page" do
        a = Article.create(title: "Some Title", body: "Muhahaha <script>alert('Malicious code')</script>")
        get "/articles/#{a.id.to_s}"
        expect(response.body).to_not include("<script>")
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

    after(:all) do
      @u.destroy!
    end

  end

end