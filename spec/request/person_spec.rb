require 'rails_helper'

RSpec.describe Person, type: :request do

  before(:all) do
    @p = FactoryBot.create(:person)
    @u = @p.user
    post "/users/login", params: {email: @u.email, password: @u.password}
  end

  it "should let you edit your profile" do
    patch "/admin/people/#{@p.id}", params: { person: {given_name: "New Name"}}
    expect(@p.reload.given_name).to eq("New Name")
  end

  it "should not let you edit someone else's profile" do
    @p2 = FactoryBot.create(:person, given_name: "Muhaha you can't change this")
    patch "/admin/people/#{@p2.id}", params: { person: {given_name: "New Name"}}
    expect(@p2.reload.given_name).to eq("Muhaha you can't change this")
  end

  after(:all) do
    @p.destroy!
    @u.destroy!
  end
end
