class S3Connection
  def initialize(bucket_name, test_mode: false)
    # takes in client as the argumen
    if test_mode
      @s3 = Aws::S3::Client.new(stub_responses: true)
      @bucket_name = bucket_name
    else
      @bucket = Aws::S3::Bucket.new(bucket_name)
    end
  end

  # Creates a presigned URL that can be used to upload content to an object.
  #
  # @param bucket [Aws::S3::Bucket] An existing Amazon S3 bucket.
  # @param object_key [String] The key to give the uploaded object.
  # @return [URI, nil] The parsed URI if successful; otherwise nil.
  def get_presigned_url(object_key)
    begin
      if @bucket
        url = @bucket.object(object_key).presigned_url(:put)
        puts "Created presigned URL: #{url}"
        return url
      else
        presigner = Aws::S3::Presigner.new(client: @s3)
        presigner.presigned_url(:put_object, bucket: @bucket_name, key: object_key)
      end
    rescue Aws::Errors::ServiceError => e
      puts "Couldn't create presigned URL for #{bucket.name}:#{object_key}. Here's why: #{e.message}"
    end
  end
end