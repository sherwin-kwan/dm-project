require 'rails_helper'

RSpec.describe Person, type: :model do
  it "can speak" do
    p = Person.create
    expect(p.speak).to eq("Hello, world!")
  end
end
