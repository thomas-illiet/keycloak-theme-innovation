# Workflows

## Validation Workflow

File:

```text
.github/workflows/validate.yml
```

Runs on:

- every push
- every pull request
- manual dispatch

The workflow validates that each commit still builds:

1. Resolves the target Keycloak version.
2. Runs `scripts/validate-theme.sh`.
3. Builds the ready-to-use JAR.
4. Builds a Docker image with the resolved Keycloak version.
5. Uploads the generated JAR and metadata as workflow artifacts.

By default it targets the latest stable Keycloak release. Manual runs can override the version.

## Release Workflow

File:

```text
.github/workflows/release.yml
```

Runs on:

- published GitHub releases
- manual dispatch against an existing release tag

The default release target is:

```text
latest-5
```

That means the workflow resolves the five latest stable Keycloak versions, builds one JAR per version, validates each Docker image, generates checksums, and uploads the JARs plus `SHA256SUMS` to the GitHub release.

Release assets:

```text
ai-innovation-keycloak-theme-<KEYCLOAK_VERSION>.jar
SHA256SUMS
```

Assets are uploaded with `gh release upload --clobber`, so rerunning the release workflow updates existing files.

## Manual Release Refresh

Use the manual `Release` workflow with:

```text
release_tag = vX.Y.Z
keycloak_versions = latest-5
```

You can also provide explicit versions:

```text
keycloak_versions = 26.6.2,26.6.1,26.6.0
```

This is useful when Keycloak publishes new patch releases after an existing theme release.
