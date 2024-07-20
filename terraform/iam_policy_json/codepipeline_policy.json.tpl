{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "codecommit:GitPull",
        "codecommit:GitPush",
        "codecommit:GetRepository",
        "codecommit:ListBranches",
        "codecommit:GetBranch",
        "codecommit:BatchGetRepositories",
        "codecommit:GetRepositoryTriggers",
        "codecommit:CreateBranch"
      ],
      "Resource": "arn:aws:codecommit:${REGION}:${ACCOUNT_ID}:${REPOSITORY_NAME}"
    }
  ]
}
