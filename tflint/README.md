# tflint

`tflint` is a Terraform linter for detecting errors that can not be detected by `terraform plan`.

## Usage

```bash
docker run --rm --pull always -v $(pwd):/data:ro ghcr.io/tbckr/tflint:latest --recursive
```
