# Changelog

## Unreleased

### Added

- Add `--only-safe` option to `correct` and `pick` command (default: `true`).

## 0.5.0 - 2022-05-16

### Changed

- Change required ruby version from 3.0 to 3.1.

## 0.4.0 - 2022-05-16

### Fixed

- Fix misspell: `occured` -> `occurred`.

## 0.3.0 - 2022-05-15

### Changed

- Change `describe` output so that commit-message-ready text is described.

## 0.2.0 - 2022-05-15

### Added

- Add `correct` command.

### Changed

- Improve description on no named example.

## 0.1.1 - 2022-05-15

### Changed

- Abort if no cop was picked on `pick` command.

### Fixed

- Fix bug that `pick` cannot find any cop on rubocop >= 1.26.

## 0.1.0 - 2022-05-15

### Added

- Initial release.
