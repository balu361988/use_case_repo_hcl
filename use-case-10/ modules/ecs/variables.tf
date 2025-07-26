variable "execution_role_arn" {}
variable "patient_image" {}
variable "appointment_image" {}
variable "subnet_ids" {
  type = list(string)
}
variable "service_sg_id" {}
variable "patient_target_group_arn" {}
variable "appointment_target_group_arn" {}
