variable "working_dir" {}
variable "build_command" {}
variable "triggers" {
  default = { }
}
variable "source_dir" {}
variable "output_file" {}
variable "cleanup_command" {}
variable "tags" {
  default = {}
}