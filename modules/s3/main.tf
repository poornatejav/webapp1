resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name
}

resource "aws_s3_object" "s3_object" {
  bucket = var.bucket_name
  key    = var.object_key
  source = var.source_path
}