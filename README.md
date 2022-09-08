# Terraform build with cleanup stage 

If you're using Terraform in a way that can manipulate the local filesystem
(e.g., `local-exec`), it's possible your commands might leave some artefacts
lying around. Artefacts that later cause problems when trying to generate 
checksums for whether files have changed 🤦‍♂️.

This module helps alleviate the problem by running a separate cleanup command
once your build command is finished.

## Usage

```hcl
module "build" {
  source  = "glenngillen/build-with-cleanup/module"
  version = "1.0.0"

  working_dir = "app/path/here"
  build_command = <<EOF
echo "hello" > world.txt
EOF
  source_dir  = "app/path/here/build"
  output_file = "${path.cwd}/build.zip"
  cleanup_command = "rm -rf world.txt"
}
```