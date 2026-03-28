output "profile_id" {
  value = join("", aws_iam_instance_profile.instance_profile.*.id)
}

output "profile_arn" {
  value = join("", aws_iam_instance_profile.instance_profile.*.arn)
}

output "profile_name" {
  value = join("", aws_iam_instance_profile.instance_profile.*.name)
}

output "profile_path" {
  value = join("", aws_iam_instance_profile.instance_profile.*.path)
}

output "profile_role" {
  value = join("", aws_iam_instance_profile.instance_profile.*.role)
}

output "profile_unique_id" {
  value = join("", aws_iam_instance_profile.instance_profile.*.unique_id)
}

output "role_arn" {
  value = join("", aws_iam_role.default_role.*.arn)
}

output "role_id" {
  value = join("", aws_iam_role.default_role.*.id)
}
