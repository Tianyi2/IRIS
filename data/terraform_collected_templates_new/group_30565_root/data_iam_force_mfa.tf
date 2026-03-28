data "aws_iam_policy_document" "iam_enforce_mfa" {

  statement {
    sid = "DenyAllExceptListedIfNoMFA"
    effect = "Deny"
    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
      "sts:GetSessionToken",
      "sts:AssumeRole",
      "iam:ChangePassword"
    ]
    resources = [
      "*"
    ]
    condition {
      test = "BoolIfExists"
      values = ["false"]
      variable = "aws:MultiFactorAuthPresent"
    }
  }

  statement {
    sid = "AllowAllUsersToListAccounts"
    effect = "Allow"
    actions = [
      "iam:ListAccountAliases",
      "iam:ListUsers",
      "iam:GetAccountSummary"
    ]
    resources = [
		"*"
    ]
  }

  statement {
    sid = "AllowIndividualUserToSeeAndManageTheirOwnAccountInformation"
    effect = "Allow"
    actions = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:CreateLoginProfile",
      "iam:DeleteAccessKey",
      "iam:DeleteLoginProfile",
      "iam:GetAccountPasswordPolicy",
      "iam:GetLoginProfile",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
      "iam:UpdateLoginProfile",
      "iam:ListSigningCertificates",
      "iam:DeleteSigningCertificate",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
      "iam:ListSSHPublicKeys",
      "iam:GetSSHPublicKey",
      "iam:DeleteSSHPublicKey",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey"
    ]
    resources = [
		"arn:aws:iam::${var.account_id}:group/Enforce_MFA"
    ]
  }

  statement {
    sid = "AllowIndividualUserToManageTheirOwnMFA"
    effect = "Allow"
    actions = [
      "iam:ListVirtualMFADevices",
      "iam:ListMFADevices",
      "iam:CreateVirtualMFADevice",
      "iam:DeactivateMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:RequestSmsMfaRegistration",
      "iam:FinalizeSmsMfaRegistration",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice"
    ]
    resources = [
        "arn:aws:iam::${var.account_id}:mfa/*",
        "arn:aws:iam::${var.account_id}:group/Enforce_MFA"
    ]
  }
}
