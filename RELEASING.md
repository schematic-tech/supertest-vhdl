# Releasing

The interop library is dual licensed under **MIT OR Apache-2.0**, at the recipient's
option. Both license texts ship with the package. `VERSION` is the stable release
version and must agree with all package metadata.

Development happens in `schematic-internal`. A release is a squash snapshot copied
to the repository of the same name under `schematic-tech`. These workflows do not
copy history, create public repositories, or push release tags.

## Trigger and behavior

After copying the reviewed snapshot to the public repository, commit it, then push
a matching version tag such as `v0.1.0`. `.github/workflows/release.yml` runs CI,
builds and tests the installable artifacts, and publishes the same verified artifacts.
It only publishes from this repository's exact `schematic-tech` name. A private-repo
tag does not publish. A normal branch push only runs CI.

The publish job uses a GitHub environment named **release**. Create that environment
in the public repository before the first release. Set its deployment rules to
allow the release tags. Required reviewers are optional; omit them if tag pushes
should publish without a second manual step. Keep Actions enabled and allow the
pinned actions used in these workflows. GitHub release uploads use the automatically
provided `GITHUB_TOKEN`; no GitHub personal access token is needed.

All public GitHub releases include source `.tar.gz` and `.zip` archives, both
licenses, and `SHA256SUMS`, alongside the language-specific artifacts. Assets are
uploaded to a draft first and the draft is then published. Already published
GitHub release assets are not overwritten on retries.

## Versions and retries

Update `VERSION` and the language's package metadata together. The first prepared
version is `0.1.0`. The release validator rejects tags that do not match the package
version. Run CI on the final public squash commit before tagging it.

If publication fails partway through, correct the external configuration and rerun
the failed GitHub Actions run for the same tag. Registry uploads skip versions
already uploaded during an earlier attempt. Do not change the contents of an
already published version or move a published tag; use a new version for code fixes.

Registry publication is separate from checker support. These packages provide
markers and runtime assumptions; they do not expand Pup/backend language discovery.

## VHDL and FuseSoC

There are no registry credentials to configure. GitHub Actions publishes
`schematic.vhd` plus versioned source archives using its normal `GITHUB_TOKEN`.
The source archives contain the FuseSoC CAPI2 manifest `schematic-supertest.core`.
The core identifier is `schematic:verification:supertest:<version>`.

Consumers may copy the source into their simulator's project or add a tagged
checkout as a FuseSoC library. CI tests the assumptions with GHDL and runs the
FuseSoC simulation target. No simulator-specific compiled library is distributed.

After a `v0.1.0` release, the standalone source is at:

- `https://github.com/schematic-tech/supertest-vhdl/releases/download/v0.1.0/schematic.vhd`
- `https://raw.githubusercontent.com/schematic-tech/supertest-vhdl/v0.1.0/src/schematic.vhd`

Use a tag or commit when pinning a dependency. The standalone source retains the
MIT text and the Apache-2.0 licensing option in comments.
