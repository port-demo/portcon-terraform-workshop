locals {
  queue_name     = var.fifo ? "${var.tags["service"]}-${var.tags["environment"]}.fifo" : "${var.tags["service"]}-${var.tags["environment"]}"
  dlq_queue_name = var.fifo ? "${var.tags["service"]}-${var.tags["environment"]}-dlq.fifo" : "${var.tags["service"]}-${var.tags["environment"]}-dlq"
}

resource "aws_sqs_queue" "dlq" {
  count = var.dead_letter_queue ? 1 : 0

  name                        = local.dlq_queue_name
  fifo_queue                  = var.fifo
  content_based_deduplication = var.fifo ? true : null

  kms_master_key_id                 = var.kms_encryption ? "" : null
  kms_data_key_reuse_period_seconds = var.kms_encryption ? 300 : null

  message_retention_seconds = 1209600 # 14 days

  tags = merge(
    var.tags,
    {
      queue_type = "dead-letter"
    }
  )
}

resource "aws_sqs_queue" "this" {
  name                        = local.queue_name
  fifo_queue                  = var.fifo
  content_based_deduplication = var.fifo ? true : null

  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = 345600 # 4 days
  max_message_size           = 262144 # 256 KB
  delay_seconds              = 0
  receive_wait_time_seconds  = 0

  kms_master_key_id                 = var.kms_encryption ? "" : null
  kms_data_key_reuse_period_seconds = var.kms_encryption ? 300 : null

  redrive_policy = var.dead_letter_queue ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq[0].arn
    maxReceiveCount     = 3
  }) : null

  tags = var.tags
}
