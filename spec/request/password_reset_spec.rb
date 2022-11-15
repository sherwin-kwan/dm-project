require 'rails_helper'

RSpec.describe "password resets", type: :request do
  before(:all) do
    @u = FactoryBot.create(:user)
  end

  it "can handle password resets" do
    post "/send_password_reset", params: {email: @u.email}
    expect(@u.reload.reset_token_digest).to be_truthy
    time_until_expiry = @u.reset_token_expiry_time - Time.now
    # Add in a one-second hedge, otherwise the test will fail because it's "only" 3599.99 seconds until expiry
    expect((3600 - time_until_expiry).abs < 1).to be(true)
  end

  after(:all) do
    @u.destroy!
  end
end