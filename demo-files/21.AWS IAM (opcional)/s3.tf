resource "aws_s3_bucket" "demo_bucket" {
  bucket = "terralabs-15923" # el nombre del bucket debe ser unico.
}

resource "aws_s3_bucket_acl" "remote_state" {
  bucket = aws_s3_bucket.demo_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "demo_file" {
  bucket      = aws_s3_bucket.demo_bucket.id
  key         = "demo_s3.png"
  source      = "assets/demo_s3.png"
  content_type = "image/jpeg"

  acl = "public-read"
}

