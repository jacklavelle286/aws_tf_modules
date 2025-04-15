resource "aws_sns_topic" "this" {
  name = var.topic_name
}

resource "aws_sns_topic_subscription" "this" {
  count = length(var.subscribers)
  topic_arn = aws_sns_topic.this.arn
  protocol  = var.subscribers[count.index].protocol
  endpoint  = var.subscribers[count.index].endpoint 
}