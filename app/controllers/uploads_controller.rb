class UploadsController < AdminController
  def get_presigned_url
    s3 = S3Connection.new(ENV["AWS_S3_BUCKET_NAME"])
    render json: {presigned_url: s3.get_presigned_url("aasdfasdfasdfasfasdf.jpg")}
  end
end