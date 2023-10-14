# release-please

[release-please](https://github.com/googleapis/release-please) is a Node CLI that automatically creates releases for
your repository.

The tags correspond to the node version used in the docker image. Available tags:

- 18

## Usage

Run with default config:

```bash
docker run --rm --pull always -v $(pwd):/app:rw ghcr.io/tbckr/release-please:18
```
