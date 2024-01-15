resource "aws_s3_bucket" "s3" {
  bucket = "${var.bucket}-${terraform.workspace}"

  tags = {
    Name    = "saju-front-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_public_access_block" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  depends_on = [
    aws_s3_bucket_public_access_block.s3_public_access_block
  ]

  bucket = aws_s3_bucket.s3.id
  policy = local.policy
}

resource "aws_s3_bucket_website_configuration" "s3_website" {
  bucket = aws_s3_bucket.s3.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }

}

locals {
  policy = <<-EOF
  {
    "Id" : "Policy1704975873815",
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Stmt1704975872064",
        "Action" : [
          "s3:GetObject"
        ],
        "Effect" : "Allow",
        "Resource" : "${aws_s3_bucket.s3.arn}/*",
        "Principal" : "*"
      }
    ]
  }
  EOF
}
