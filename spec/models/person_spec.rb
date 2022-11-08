require 'rails_helper'

RSpec.describe Person, type: :model do

  it "public name should default to 'Anonymous' if not present" do
    p = Person.new
    expect(p.public_name).to eq("Anonymous")
  end

  it "private name should default to 'Friend' if not present" do
    p = Person.new
    expect(p.private_name).to eq("Friend")
  end

end
