output "bucket_id" {
    value = aws_s3_bucket.s3.id
  
}

output "bucket_arn" {
    value = aws_s3_bucket.s3.arn
  
}

output "iam_instance_profile" {
  value = aws_iam_instance_profile.ec2_s3_profile.name
}
