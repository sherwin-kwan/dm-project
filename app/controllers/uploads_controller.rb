class UploadsController < AdminController
  def get_presigned_url
    s3 = S3Connection.new(bucket_name: ENV["AWS_S3_BUCKET_NAME"])
    image_url = SecureRandom.hex(20)
    render json: {presigned_url: s3.get_presigned_url(image_url)}
  end
end