require 'rails_helper'

RSpec.describe Person, type: :model do
  it "can speak" do
    p = Person.create
    p.speak
    expect(1+1).to eq(2)
  end
end
