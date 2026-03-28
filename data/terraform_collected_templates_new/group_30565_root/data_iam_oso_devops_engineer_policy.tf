data "aws_iam_policy_document" "oso_devops_engineer" {

 statement {
    sid = "GeneralAdminAccess"
    effect = "Allow"
    actions = [
      "acm:*",
      "artifact:*",
      "apigateway:*",
      "application-autoscaling:*",
      "appmesh:*",
      "appstream:*",
      "athena:*",
      "autoscaling:*",
      "autoscaling-plans:*",
      "connect:*",
      "clouddirectory:*",
      "cloud9:*",
      "cloudformation:*",
      "cloudfront:*",
      "cloudhsm:*",
      "cloudsearch:*",
      "cloudtrail:*",
      "cloudwatch:*",
      "codebuild:*",
      "codecommit:*",
      "codedeploy:*",
      "codepipeline:*",
      "codestar:*",
      "cognito:*",
      "cognito-identity:*",
      "cognito-idp:*",
      "cognito-sync:*",
      "config:*",
      "batch:*",
      "datapipeline:*",
      "discovery:*",
      "dlm:*",
      "dms:*",
      "ds:*",
      "directconnect:*",
      "dynamodb:*",
      "dax:*",
      "ec2:*",
      "ec2messages:*",
      "ecr:*",
      "ecs:*",
      "eks:*",
      "elasticfilesystem:*",
      "elasticloadbalancing:*",
      "elasticmapreduce:*",
      "elasticache:*",
      "es:*",
      "events:*",
      "execute-api:*",
      "firehose:*",
      "inspector:*",
      "glacier:*",
      "glue:*",
      "guardduty:*",
      "health:*",
      "importexport:*",
      "inspector:*",
      "kinesis:*",
      "kms:*",
      "lambda:*",
      "lightsail:*",
      "logs:*",
      "maice:*",
      "mgh:*",
      "mq:*",
      "pricing:*",
      "rds:*",
      "redshift:*",
      "resource-groups:*",
      "route53:*",
      "route53domains:*",
      "s3:*",
      "ses:*",
      "secretsmanager:*",
      "servicediscovery:*",
      "shield:*",
      "sdb:*",
      "sso:*",
      "sns:*",
      "sqs:*",
      "states:*",
      "sts:*",
      "swf:*",
      "storagegateway:*",
      "tag:*",
      "translate:*",
      "trustedadvisor:*",
      "waf:*",
      "waf-regional:*",
      "xray:*",
      "aws-marketplace:*",
      "aws-marketplace-management:*",
    ]

    resources = [
		"*"
    ]
  }

  statement {
    sid = "AWSsupportAccess"
    effect = "Allow"
    actions = ["support:*"]
    resources = ["*"]
  }

  statement {
    sid = "AllowCreateIAMRoles"
    effect = "Allow"
    actions = [
      "iam:AddRoleToInstanceProfile",
      "iam:RemoveRoleFromInstanceProfile",
      "iam:AttachRolePolicy",
      "iam:List*",
      "iam:Get*",
      "iam:Delete*",
      "iam:Create*",
      "iam:DetachRolePolicy",
      "iam:Update*",
      "iam:PassRole",
      "iam:Simulate*",
      "iam:GenerateServiceLastAccessDetails",
      "iam:SetDefaultPolicyVersion",
      "iam:PutRolePolicy"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Deny"
    actions = [
      "kms:RetireGrant",
      "kms:RevokeGrant",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
      "kms:DisableKey",
      "kms:Delete*"
    ]
    resources = [
      "*"
    ]

  }

  statement {
    sid = "PeventModifyingSelfGroup"
    effect = "Deny"
    actions = [
      "iam:AttachGroupPolicy",
      "iam:DetachGroupPolicy"
    ]
    resources = [
      "arn:aws:iam::${var.account_id}:group/OSO_DevOps_Engineering",
    ]
  }

  statement {
    sid = "PeventModifyingSelf"
    effect = "Deny"
    actions = [
      "iam:CreatePolicyVersion",
      "iam:CreatePolicy"
    ]
    resources = [
      "arn:aws:iam::${var.account_id}:policy/oso-devops-engineer-group-policy",
    ]
  }

  statement {

    sid = "SystemManagerAccess"
    effect = "Allow"
    actions = [
      "ssm:AddTagsToResource",
      "ssm:CancelCommand",
      "ssm:CancelMaintenanceWindowExecution",
      "ssm:CreateActivation",
      "ssm:CreateAssociation",
      "ssm:CreateAssociationBatch",
      "ssm:CreateDocument",
      "ssm:CreateMaintenanceWindow",
      "ssm:CreateOpsItem",
      "ssm:CreatePatchBaseline",
      "ssm:CreateResourceDataSync",
      "ssm:DeleteActivation",
      "ssm:DeleteAssociation",
      "ssm:DeleteDocument",
      "ssm:DeleteInventory",
      "ssm:DeletePatchBaseline",
      "ssm:DeleteResourceDataSync",
      "ssm:DeregisterManagedInstance",
      "ssm:DeregisterPatchBaselineForPatchGroup",
      "ssm:DeregisterTargetFromMaintenanceWindow",
      "ssm:DeregisterTaskFromMaintenanceWindow",
      "ssm:DescribeActivations",
      "ssm:DescribeAssociation",
      "ssm:DescribeAssociationExecutions",
      "ssm:DescribeAssociationExecutionTargets",
      "ssm:DescribeAutomationExecutions",
      "ssm:DescribeAutomationStepExecutions",
      "ssm:DescribeAvailablePatches",
      "ssm:DescribeDocument",
      "ssm:DescribeDocumentPermission",
      "ssm:DescribeEffectiveInstanceAssociations",
      "ssm:DescribeEffectivePatchesForPatchBaseline",
      "ssm:DescribeInstanceAssociationsStatus",
      "ssm:DescribeInstanceInformation",
      "ssm:DescribeInstancePatches",
      "ssm:DescribeInstancePatchStates",
      "ssm:DescribeInstancePatchStatesForPatchGroup",
      "ssm:DescribeInventoryDeletions",
      "ssm:DescribeMaintenanceWindowExecutions",
      "ssm:DescribeMaintenanceWindowExecutionTaskInvocations",
      "ssm:DescribeMaintenanceWindowExecutionTasks",
      "ssm:DescribeMaintenanceWindows",
      "ssm:DescribeMaintenanceWindowSchedule",
      "ssm:DescribeMaintenanceWindowsForTarget",
      "ssm:DescribeMaintenanceWindowTargets",
      "ssm:DescribeMaintenanceWindowTasks",
      "ssm:DescribeOpsItems",
      "ssm:DescribePatchBaselines",
      "ssm:DescribePatchGroups",
      "ssm:DescribePatchGroupState",
      "ssm:DescribePatchProperties",
      "ssm:DescribeSessions",
      "ssm:GetAutomationExecution",
      "ssm:GetCommandInvocation",
      "ssm:GetConnectionStatus",
      "ssm:GetDefaultPatchBaseline",
      "ssm:GetDeployablePatchSnapshotForInstance",
      "ssm:GetDocument",
      "ssm:GetInventory",
      "ssm:GetInventorySchema",
      "ssm:GetMaintenanceWindow",
      "ssm:GetMaintenanceWindowExecution",
      "ssm:GetMaintenanceWindowExecutionTask",
      "ssm:GetMaintenanceWindowExecutionTaskInvocation",
      "ssm:GetMaintenanceWindowTask",
      "ssm:GetOpsItem",
      "ssm:GetOpsSummary",
      "ssm:GetPatchBaseline",
      "ssm:GetPatchBaselineForPatchGroup",
      "ssm:GetServiceSetting",
      "ssm:ListAssociations",
      "ssm:ListAssociationVersions",
      "ssm:ListCommandInvocations",
      "ssm:ListCommands",
      "ssm:ListComplianceItems",
      "ssm:ListComplianceSummaries",
      "ssm:ListDocuments",
      "ssm:ListDocumentVersions",
      "ssm:ListInventoryEntries",
      "ssm:ListResourceComplianceSummaries",
      "ssm:ListResourceDataSync",
      "ssm:ListTagsForResource",
      "ssm:ModifyDocumentPermission",
      "ssm:PutComplianceItems",
      "ssm:PutInventory",
      "ssm:RegisterDefaultPatchBaseline",
      "ssm:RegisterPatchBaselineForPatchGroup",
      "ssm:RegisterTargetWithMaintenanceWindow",
      "ssm:RegisterTaskWithMaintenanceWindow",
      "ssm:RemoveTagsFromResource",
      "ssm:ResetServiceSetting",
      "ssm:ResumeSession",
      "ssm:SendAutomationSignal",
      "ssm:SendCommand",
      "ssm:StartAssociationsOnce",
      "ssm:StartAutomationExecution",
      "ssm:StartSession",
      "ssm:StopAutomationExecution",
      "ssm:TerminateSession",
      "ssm:UpdateAssociation",
      "ssm:UpdateAssociationStatus",
      "ssm:UpdateDocument",
      "ssm:UpdateDocumentDefaultVersion",
      "ssm:UpdateMaintenanceWindow",
      "ssm:UpdateMaintenanceWindowTarget",
      "ssm:UpdateMaintenanceWindowTask",
      "ssm:UpdateManagedInstanceRole",
      "ssm:UpdateOpsItem",
      "ssm:UpdatePatchBaseline",
      "ssm:UpdateServiceSetting",
    ]
    resources = [
		"*"
    ]
  }

  statement {

    sid = "AllowParameterAccess"
    effect = "Allow"
    actions = [
      "ssm:DescribeParameters",
      "ssm:GetParameterHistory",
      "ssm:GetParametersByPath",
      "ssm:GetParameters",
      "ssm:GetParameter",
      "ssm:LabelParameterVersion"
    ]
    resources = [
		"arn:aws:ssm:${var.region}:${var.account_id}:parameter/VPN-*",
        "arn:aws:ssm:${var.region}:${var.account_id}:parameter/PROD-TABLEAU-*"
    ]
  }
}
