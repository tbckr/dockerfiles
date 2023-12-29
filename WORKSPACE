# This file marks the root of the Bazel workspace.
# See MODULE.bazel for external dependencies setup.

workspace(name = "com_tbckr_dockerfiles")

load("@rules_oci//oci:pull.bzl", "oci_pull")
oci_pull(
    name = "distroless_static_debian12",
    image = "gcr.io/distroless/static-debian12",
)