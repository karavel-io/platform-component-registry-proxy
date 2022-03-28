# Release Guide

This guide is intended for contributors and maintainers with release duty on this project.  
This project follows the [SemVer 2.0] `MAJOR.MINOR.PATCH` format

## Preparing a minor release

A minor release should introduce backward-compatible features and improvements. An end-user must be able to update from
a minor release to the next (e.g. from `1.2.5` to `1.3.0`) without any manual intervention.

To release a new minor version of this component, create a branch called `release/X.Y.0` (e.g. `release/1.3.0`) from `main`.
This branch will host the last-minute changes and fixes in preparation for the actual release. Follow this release checklist:

- [ ] Update the [CHANGELOG](CHANGELOG.md) by moving all `Unreleased` entries to a new section called `[X.Y.0] - YYYY-MM-DD`
- [ ] Update the [Chart.yaml] `version` field

### Creating the release
Once the pull request is approved and merged, immediately create a new branch called `X.Y` from `main`, then tag the new version
by running `git tag X.Y.0` on that branch. A [CI job](https://github.com/projectkaravel/platform-component-example/actions/workflows/release.yml) 
will kick in, packaging the component and creating the corresponding [release](https://github.com/projectkaravel/platform-component-example/releases).

Edit the release body with the relevant CHANGELOG section and publish it.

Congratulations, you just released a new version!

### Deprecating a release

Each minor release must be supported for as long as there is a [Karavel Container Platform] version that uses it.
This usually means that a component must be supported for a year since it was first bundled in a Platform version, although
this period can be shorter if the Platform decides to update the component sooner. 
When the last Platform version referencing it gets deprecated, so does the component release.

Until then, bugfixes must be backported to all supported minor releases. See the next section for more information.

## Preparing a patch release

Sometimes, bugs are found in a component released that must be quickly fixed and released to users.
When a bug is found, a bugfix should be implemented by forking the oldest affected release branch (e.g. `1.3`).

For example, let's assume the latest release is `1.4.2`, and we're fixing a bug that affects both `1.4.2` and `1.3.1` versions
of the component.

Create a branch called `bugfix/something-descriptive` starting from the `1.3` branch, implement the fix, then open a pull request targeting
the `1.3` branch. Be sure to include the following steps in the bugfix PR:

- [ ] Update the [CHANGELOG](CHANGELOG.md) by adding the relevant entries to a new section called `[X.Y.Z] - YYYY-MM-DD`
- [ ] Update the [Chart.yaml] `version` field

Once the PR gets merged, backport the change by opening a pull request from `1.3` to `1.4`. This is called "backporting a fix". Be sure to update
the [Chart.yaml] `version` field with the proper `1.4` version, and NOT the `1.3` one coming from the source branch.

Next, backport the fix to `main` by opening a PR from `1.4`. Ideally, all PRs should be merged with [Rebase and Merge] to keep the history linear and avoid merge commits.

Finally, the fix must be released as a new patch version for both `1.3` and `1.4`. This is done by creating the following tags:

- on branch `1.3`, create tag `1.3.2`
- on branch `1.4`, create tag `1.4.3`

At that point, the release process is the same as for a minor version. Just follow the same steps as described in the ["Creating the release"](#creating-the-release)
section, once per each new tag.

Congratulations, you just released a new patch version!

[SemVer 2.0]: https://semver.org/
[Karavel Container Platform]: https://github.com/projectkaravel/platform
[Chart.yaml]: chart/Chart.yaml
[Rebase and merge]: Rebasing and merging your commits
