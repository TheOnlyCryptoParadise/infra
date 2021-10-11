terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_iam_policy" "dynamodb_policy" {
  name        = "dynamodb-policy"
  description = "A dynamodb full access policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}

resource "aws_s3_bucket" "b" {
  bucket = "crp-s3-code"
  acl    = "private"
}



# Upload an object
resource "aws_s3_bucket_object" "layer_libs_file" {
  bucket = aws_s3_bucket.b.id
  key    = "candle_getter_layer_libs"
  acl    = "private"
  source = var.candle_layer_location
  etag = filemd5(var.candle_layer_location)
}
resource "aws_s3_bucket_object" "function_code_file" {
  bucket = aws_s3_bucket.b.id
  key    = "candle_getter_code"
  acl    = "private"
  source = var.candle_getter_package_location
  etag = filemd5(var.candle_getter_package_location)

}


resource "aws_lambda_layer_version" "candle_getter_layer" {
  s3_bucket = aws_s3_bucket.b.id
  s3_key    = aws_s3_bucket_object.layer_libs_file.key
  layer_name = "candle_getter_layer"
  compatible_runtimes = ["python3.7"]
}


resource "aws_lambda_function" "test_lambda" {
  function_name = "candle_getter"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "main.aws_handler"
  s3_bucket = aws_s3_bucket.b.id
  s3_key = aws_s3_bucket_object.function_code_file.key
  layers = [aws_lambda_layer_version.candle_getter_layer.arn]
  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  #source_code_hash = filebase64sha256("lambda_function_payload.zip")
  timeout = 55
  memory_size = 256
  runtime = "python3.7"

  environment {
    variables = {
      CANDLE_GETTER_MODE = "PRODUCTION"
    }
  }
}
