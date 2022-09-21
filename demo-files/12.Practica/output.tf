output "bucket_url" {
  value = "${aws_s3_object.demo_file.bucket}.s3.amazonaws.com/${aws_s3_object.demo_file.key}"
}
