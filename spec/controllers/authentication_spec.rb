require 'rails_helper'

RSpec.describe "Authentication", type: :request do

  context "before logging in" do 
    it "when not logged in, user sees 'Log In' and 'Sign Up' on the navbar" do
      get "/"
      expect(response.body).to include("Log In")
      expect(response.body).to include("Sign Up")
      expect(response.body).to_not include("Log Out")
    end
  end

  context "after logging in" do

    before(:all) do
      @u = FactoryBot.create(:user)
      post "/users/login", params: {email: @u.email, password: @u.password}
    end

    it "user can log in" do
      expect(session[:user_id]).to eq(@u.id)
    end

    it "user sees 'Log Out' on the navbar" do
      get "/"
      expect(response.body).to include("Log Out")
      expect(response.body).to_not include("Log In")
      expect(response.body).to_not include("Sign Up")
    end

    it "once logged in, user can log out" do
      delete "/users/logout"
      expect(session[:user_id]).to eq(nil)
    end

    after(:all) do
      @u.destroy!
    end
  
  end

end