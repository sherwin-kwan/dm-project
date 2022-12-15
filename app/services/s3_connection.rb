class S3Connection
  def initialize(bucket_name)
    @bucket = Aws::S3::Bucket.new(bucket_name)
  end

  # Creates a presigned URL that can be used to upload content to an object.
  #
  # @param bucket [Aws::S3::Bucket] An existing Amazon S3 bucket.
  # @param object_key [String] The key to give the uploaded object.
  # @return [URI, nil] The parsed URI if successful; otherwise nil.
  def get_presigned_url(object_key)
    url = @bucket.object(object_key).presigned_url(:put)
    puts "Created presigned URL: #{url}"
    return URI(url)
  rescue Aws::Errors::ServiceError => e
    puts "Couldn't create presigned URL for #{bucket.name}:#{object_key}. Here's why: #{e.message}"
  end

end