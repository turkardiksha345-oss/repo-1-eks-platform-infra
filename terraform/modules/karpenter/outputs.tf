# eks-platform-infra/terraform/modules/karpenter/outputs.tf

output "interruption_queue_name" {
  description = "Name of the Karpenter interruption SQS queue"
  value       = aws_sqs_queue.karpenter_interruption.name
}

output "interruption_queue_arn" {
  description = "ARN of the Karpenter interruption SQS queue"
  value       = aws_sqs_queue.karpenter_interruption.arn
}
