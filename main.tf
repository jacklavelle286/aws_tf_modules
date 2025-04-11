
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

module "cloudfront" {
  source                 = "./modules/cloudfront"
  origin_id              = module.aws_s3_bucket.bucket_id
  target_origin_id       = module.aws_s3_bucket.bucket_id
  viewer_protocol_policy = "allow-all"
  domain_name            = module.aws_s3_bucket.static_website_endpoint
  tags = local.default_tags
  is_default_certificate = true
}

module "dynamo_table" {
  tags = local.default_tags
  source = "./modules/dynamodb"
  name           = "GameScores"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attributes = {
    UserId    = "S"  
    GameTitle = "S"  
    TopScore  = "N"  
  }

  ttl_attribute_name = "TimeToExist"
  ttl_enabled        = true

  global_secondary_indexes = [
    {
      name              = "GameTitleIndex"
      hash_key          = "GameTitle"
      range_key         = "TopScore"
      read_capacity     = 10
      write_capacity    = 10
      projection_type   = "INCLUDE"
      non_key_attributes = ["UserId"]
    }
  ]

}



module "aws_s3_bucket" {
  tags = local.default_tags
  source = "./modules/s3"
  name = var.bucket_name
  is_policy_document = false

}

module "eventbridge" {
  source = "./modules/eventbridge"
  eventbus_name = var.eventbus_name
  is_default_eventbus = false
  sid = "sid"
  effect = "Allow"
  actions = ["PutEvents", "DescribeRule"]
  principal_type = "AWS"
  identifiers = [ "123836789016" ]
  resources = [ "arn:aws:events:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:event-bus/${var.eventbus_name}" ]

}