
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}


# module "cloudfront" {
#   source                 = "./modules/cloudfront"
#   origin_id              = module.aws_s3_bucket.bucket_id
#   target_origin_id       = module.aws_s3_bucket.bucket_id
#   viewer_protocol_policy = "allow-all"
#   domain_name            = module.aws_s3_bucket.static_website_endpoint
#   tags = local.default_tags
#   is_default_certificate = true
# }

# module "dynamo_table" {
#   tags = local.default_tags
#   source = "./modules/dynamodb"
#   name           = "GameScores"
#   billing_mode   = "PROVISIONED"
#   read_capacity  = 20
#   write_capacity = 20
#   hash_key       = "UserId"
#   range_key      = "GameTitle"

#   attributes = {
#     UserId    = "S"  
#     GameTitle = "S"  
#     TopScore  = "N"  
#   }

#   ttl_attribute_name = "TimeToExist"
#   ttl_enabled        = true

#   global_secondary_indexes = [
#     {
#       name              = "GameTitleIndex"
#       hash_key          = "GameTitle"
#       range_key         = "TopScore"
#       read_capacity     = 10
#       write_capacity    = 10
#       projection_type   = "INCLUDE"
#       non_key_attributes = ["UserId"]
#     }
#   ]

# }



# module "aws_s3_bucket" {
#   tags = local.default_tags
#   source = "./modules/s3"
#   name = var.bucket_name
#   is_policy_document = false

# }

# module "eventbridge" {
  
#   source = "./modules/eventbridge"
#   eventbus_name = var.eventbus_name
#   is_default_eventbus = true
# }



# module "lambda_function" {
#   source = "./modules/lambda_container"
#   function_name = "test_function"
#   image_uri = "438465154544.dkr.ecr.eu-west-2.amazonaws.com/lambda-container-repo:latest"
#   lambda_role_name = "lambdaRole"
#   policy_statements = [
#     {
#       sid            = "AllowLambdaInvocation"
#       effect         = "Allow"
#       actions        = ["lambda:InvokeFunction"]
#       resources      = ["arn:aws:lambda:us-east-1:123456789012:function:my-function"]
#       principal_type = "AWS"
#       identifiers    = ["arn:aws:iam::123456789012:root"]
#     },
#     {
#       sid            = "AllowS3Access"
#       effect         = "Allow"
#       actions        = ["s3:GetObject"]
#       resources      = ["arn:aws:s3:::my-bucket/*"]
#     }
#   ]
# }

# module "sns_topic" {
#   source     = "./modules/sns"
#   topic_name = "MyAwesomeTopic"
#   tags = local.default_tags

#   subscribers = [
#     {
#       protocol = "email"
#       endpoint = "lavellej286@gmail.com"
#     },
#     {
#       protocol = "sms"
#       endpoint = "+447576875840"
#     }
#   ]
# }


# module "sqs_queue" {
#   source = "./modules/sqs"
#   sqs_queue_name = "test_queue"
#   tags = local.default_tags
  
# }


module "step_functions" {
  tags = local.default_tags
  policy_statements = [
    {
      sid            = "AllowLambdaInvocation"
      effect         = "Allow"
      actions        = ["lambda:InvokeFunction"]
      resources      = ["arn:aws:lambda:us-east-1:123456789012:function:my-function"]
      principal_type = "AWS"
      identifiers    = ["arn:aws:iam::123456789012:root"]
    }
  ]

  source   = "./modules/step_functions"
  sfn_name =  var.sfn_name
  start_at = "HelloState"

  states = {
    HelloState = {
      Type     = "Task"
      Resource = "arn:aws:lambda:us-east-1:123456789012:function:HelloFunction"
      End      = true
    }
  }
}




