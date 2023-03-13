require "./app/services/s3_connection"
require "aws-sdk-s3"
require "rails_helper"

RSpec.describe "Uploads" do
  before(:each) do
    conn = S3Connection.new(bucket_name: "my_test_bucket", client: Aws::S3::Client.new(stub_responses: true))
    @url = conn.get_presigned_url("abcdefghij.jpg")
  end

  it "can generate a presigned url" do
    url_regexp = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
    expect(@url).to match(url_regexp)
  end

  it "generates a presigned url with the same file name" do
    expect(@url).to include("abcdefghij.jpg")
  end

  it "generates secure presigned URLs that change every time you request a new one" do
    conn = S3Connection.new(bucket_name: "my_test_bucket", client: Aws::S3::Client.new)
    @url2 = conn.get_presigned_url("abcdefghij.jpg")
    expect(@url).to_not eq(@url2)
  end
end