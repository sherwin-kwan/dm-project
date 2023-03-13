class S3Connection
  def initialize(bucket_name:, client: nil)
    @bucket_name = bucket_name
    @client = client || Aws::S3::Client.new(
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      region: ENV["AWS_DEFAULT_REGION"]
    )
  end

  # Creates a presigned URL that can be used to upload content to an object.
  #
  # @param bucket [Aws::S3::Bucket] An existing Amazon S3 bucket.
  # @param object_key [String] The key to give the uploaded object.
  # @return [URI, nil] The parsed URI if successful; otherwise nil.
  def get_presigned_url(object_key)
    begin
      presigner = Aws::S3::Presigner.new(client: @client)
      presigner.presigned_url(:put_object, bucket: @bucket_name, key: object_key)
    rescue Aws::Errors::ServiceError => e
      puts "Couldn't create presigned URL for #{@bucket_name}:#{object_key}. Here's why: #{e.message}"
    end
  end
end