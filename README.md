# Keycloak Release

Keycloak is using GitHub Actions to automate the release of Keycloak. The release workflows do not live in the main repositories, but rather in a separate repository:

* [Keycloak release repository](https://github.com/keycloak-rel/keycloak-rel)

The reason for this is to be able to sandbox the release from the regular day to day development of Keycloak, including job queues and secrets.

In addition there is a fork of the above repository that is used for testing purposes:

* [Keycloak release testing repository](https://github.com/keycloak-rel-testing/keycloak-rel-testing)

The testing fork allows testing releases without affecting regular releases as it uses different credentials and repositories.

## Workflows

* **Announce Release**: Announces the release, which is currently limited to updating the website
* **Branch - Create Release**: Creates new release branches in all relevant repositories
* **Branch - Delete Release**: Deletes release branches when they are no longer needed
* **Re-spin Containers**: Used to re-spin containers to update the base images without an actual Keycloak release
* **Release**: Performs a regular Keycloak release
* **Release Nightly**: Performs a nightly scratch release
* **Sync forks**: Only used in testing fork to sync forked repositories
* **X ...**: Workflows prefixed with *X* are reusable workflows, called by other workflows and should not be executed directly

## Nightly releases

Nightly releases are scheduled to run every night, but can also be started manually.

To manually run a nightly release:

1. Navigate to the `Release Nightly` workflow
2. Click on `Run workflow`
3. Use workflow from: `Branch: main`
4. Click on `Run workflow`

## Regular releases

Regular releases are manually started, and should be done from release branches rather than from the main branches.

If you are releasing a new major/minor version (for example `19.0.0` and not `19.0.1`) the first step is to create the release branches:

1. Navigate to the `Branch - Create Release` workflow
2. Click on `Run workflow`
3. Use workflow from: `Branch: main`
4. Enter the major.minor version (for example if you are releasing `19.0.0` enter `19.0`)
5. Click on `Run workflow`

If you are doing a micro release (for example `19.0.1`, and not `19.0.0`) the above step is skipped as it has already been done previously for `19.0`.

Next step is to do the actual release:

1. Navigate to the `Branch - Create Release` workflow
2. Click on `Run workflow`
3. Use workflow from: `Branch: <release branch>` (for example `Branch: 19.0`)
4. branch: `<release branch>` 
5. version: `<full version>` (for example `19.0.0`)
6. Click on `Run workflow`

After the release has completed and it has been verified the release should be announced:

1. Navigate to the `Branch - Create Release` workflow
2. Click on `Run workflow`
3. Use workflow from: `Branch: <release branch>` (for example `Branch: 19.0`)
4. version: `<full version>` (for example `19.0.0`)
5. Click on `Run workflow`

That's it folks!

## Contributing to the release process

Changes to the release process should not be sent directly to the main release repository, but rather to the [testing fork](https://github.com/keycloak-rel-testing/keycloak-rel) first. This allows testing/verifying the changes prior to updating the actual release process.

First step to contributing to the release process is to get a branch created in the testing fork for your proposed changes. This allows testing your changes without affecting other changes.

After the branch is created you can send your PR to the branch, and both the `Release` and `Release Nightly` workflows should be executed against your branch to verify it.

Once the changes have been tested a PR can be opened against the main branch in the [testing fork](https://github.com/keycloak-rel-testing/keycloak-rel).

Final step is syncing changes from the testing fork to the main release repository through a PR. This is generally not a step that you need to perform as a contributor, but rather a maintainer of the release process will coordinate this last step.

Anyone that would like to make bigger changes to the release process, or are maintainers of certain parts of the release process get full access to the [keycloak-rel-testing](https://github.com/keycloak-rel-testing/) organization, but do not everyone gets access to the [main release organization]([keycloak-rel-testing](https://github.com/keycloak-rel/). The latter is intentionally very limited in the number of people that gets access to it.