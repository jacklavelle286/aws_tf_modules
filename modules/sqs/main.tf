resource "aws_sqs_queue" "this" {
  name =var.sqs_queue_name
  tags = var.tags
  fifo_queue = var.is_fifo_queue
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter-queue.arn
    maxReceiveCount     = 4
  })
}

resource "aws_sqs_queue" "deadletter-queue" {
  name = "${var.sqs_queue_name}-deadletter-queue"
}

resource "aws_sqs_queue_redrive_allow_policy" "deadletter_queue_redrive_allow_policy" {
  queue_url = aws_sqs_queue.deadletter-queue.id
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.this.arn]
  })
}