resource "aws_cloudfront_distribution" "this" {
    tags = var.tags
    default_cache_behavior {
      allowed_methods = var.allowed_methods
      cached_methods = var.cached_methods
      target_origin_id = var.target_origin_id
      viewer_protocol_policy = var.viewer_protocol_policy
      forwarded_values {
        query_string = var.query_string
        cookies {
          forward = var.forward
        }
      }
    }
    restrictions {
      geo_restriction {
        restriction_type = var.restriction_type
        locations = var.locations
      }
    }
    origin {
      domain_name = var.domain_name
      origin_id = var.origin_id
      
    }
    viewer_certificate {
      cloudfront_default_certificate = var.is_default_certificate
      acm_certificate_arn = var.is_default_certificate ? null : var.acm_certificate_arn
      iam_certificate_id  = var.is_default_certificate ? null : var.iam_certificate_id

    }
  
    enabled = var.enabled
    
}