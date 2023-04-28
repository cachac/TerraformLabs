resource "local_file" "state_demo" {
  filename = "local"
  content  = "Archivo de estado: local"
}

resource "aws_s3_bucket_ownership_controls" "state_control" {
  bucket = aws_s3_bucket.remote_state.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket" "remote_state" {
  bucket = "terralabs-remote-state-01" # el nombre del bucket debe ser unico.

  tags = {
    Environment = "dev"
  }
}

resource "aws_s3_bucket_acl" "remote_state" {
  depends_on = [aws_s3_bucket_ownership_controls.state_control]

  bucket = aws_s3_bucket.remote_state.id
  acl    = "private"
}

