output "role_name" {
  value       = "${join("",aws_iam_role.default.*.name)}"
  description = "The name of the crated role"
}

output "role_id" {
  value       = "${join("",aws_iam_role.default.*.unique_id)}"
  description = "The stable and unique string identifying the role"
}

output "role_arn" {
  value       = "${join("",aws_iam_role.default.*.arn)}"
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "role_policy_document" {
  value       = "${data.aws_iam_policy_document.default.json}"
  description = "A copy of the IAM policy document (JSON) that grants permissions to this role."
}
