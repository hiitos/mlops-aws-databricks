resource "aws_cloudwatch_event_rule" "eventbridge_rule" {
  name = var.eventbridge_rule_name
  event_pattern = jsonencode({
    source      = ["aws.codecommit"],
    detail-type = ["CodeCommit Repository State Change"],
    resources   = ["${var.codecommit_arn}"],
    detail = {
      event         = ["referenceCreated", "referenceUpdated"],
      referenceType = ["branch"],
      referenceName = ["master"]
    }
  })
}

resource "aws_cloudwatch_event_target" "eventbridge_target" {
  rule     = aws_cloudwatch_event_rule.eventbridge_rule.name
  arn      = var.codepipeline_arn
  role_arn = var.eventbridge_role
}
