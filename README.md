# Keycloak Release

Keycloak is released with GitHub Actions.

* [Keycloak release repository](https://github.com/keycloak-rel/keycloak-rel)
* [Keycloak release testing repository](https://github.com/keycloak-rel-testing/keycloak-rel-testing)

## Overview

The `Release` and `Release - Nightly` workflows leverages the same re-usable workflows for various pieces to be released. This allows doing nightly releases and regular releases with as much re-use as possible, and also allows nightly releases to serve as a fairly decent regular testing of regular releases.

## Doing a regular release

Releases are done from release branches, if you are doing a new major or minor release the first step is to create a new release branch.

This is done by running the `Branch - Create Release` workflow.

After the release branch is created a new release is done by running the `Release` workflow.

Release branches when no longer needed can be deleted with the `Branch - Delete Release` workflow.

## Doing a nightly release

Nightly releases are automatically ran every night, but can also be manually executed by running the `Release Nightly` workflow.

## Contributing to the release process

In order to be able to work with the release process, and test changes, there is a fork of the release process in [Keycloak release testing repository](https://github.com/keycloak-rel-testing/keycloak-rel-testing).

This fork uses separate forks of all repositories, and publishes artifacts to other registries than the main repository. This allows experimenting with releases without publishing to the real repositories.

To contribute to the release process you need to get write access to the `keycloak-rel-testing` repository. Then you can experiment with your changes in a separate branch in the repository (should be `username-description`, for example `stianst-operator`).

Once you have your changes pushes to the branch you can run the `Release` or `Release - Nightly` workflows and select your branch instead of main.

After you have both `Release` and `Release - Nightly` workflows working for your branch you can send a PR from that branch to [Keycloak release repository](https://github.com/keycloak-rel/keycloak-rel).