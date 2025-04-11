locals {
  default_tags = merge(
    {
      Environment = var.environment
      Project     = var.project
    },
    var.tags
  )

  final_region = var.region != "" ? var.region : data.aws_region.current.name
}
