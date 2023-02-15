require "./app/services/s3_connection"
require "aws-sdk-s3"

RSpec.describe "Uploads" do
  it "can generate a presigned url" do
    conn = S3Connection.new("my_test_bucket", test_mode: true)
    expect(conn.get_presigned_url("abcdefgh")).to include("https://s3.us-stubbed")

    url_regexp = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
    expect(conn.get_presigned_url).to match(url_regexp)
  end
end