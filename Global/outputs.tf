/*
    Outputs
*/

output "s3_terraform_backend" {
    value   = aws_s3_bucket.terraform_state.bucket
}
