# Markdownlint

Markdown lint is a node lint tool for markdown files.

- markdownlint: [github.com/DavidAnson/markdownlint](https://github.com/DavidAnson/markdownlint)
- markdownlint-cli (installed version in docker
  image): [github.com/igorshubovych/markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli)

## Usage

Run with default config:

```bash
docker run --rm --pull always -v $(pwd):/app:ro ghcr.io/tbckr/markdownlint
```

Run with custom config called `.mdl_config.yaml` in the root of your project:

```bash
docker run --rm --pull always -v $(pwd):/app:ro ghcr.io/tbckr/markdownlint . --config=.mdl_config.yaml
```