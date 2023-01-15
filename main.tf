locals {
  triggers = (length(var.triggers) > 0 ? var.triggers : { always_run = timestamp() })
}
resource "null_resource" "pre" {
  triggers = local.triggers
  provisioner "local-exec" {
    working_dir = var.working_dir 
    command = "mkdir -p ${abspath(var.source_dir)}"
  }
}

module "build" {
  source  = "glenngillen/multiline-command/gg"
  version = "1.0.0"

  depends_on = [
    null_resource.pre
  ]
 
  triggers = local.triggers
  working_dir = var.working_dir
  command     = var.build_command
}

module "compress" {
  source  = "glenngillen/archive/gg"
  version = "1.0.0"

  depends_on = [
    module.build
  ]

  triggers    = local.triggers
  output_file = var.output_file
  working_dir = var.working_dir
  source_dir  = var.source_dir
}

module "cleanup" {
  source  = "glenngillen/multiline-command/gg"
  version = "1.0.0"

  triggers = local.triggers

  depends_on = [
    module.compress
  ]
  
  working_dir = var.working_dir
  command     = var.cleanup_command
}