# homebrew-rstun

Homebrew tap for [rstun](https://github.com/exvlan/rstun) — a standalone STUN/TURN server.

The formula installs the **lean** build: STUN + TURN (UDP/TCP) + TURN REST credentials + per-allocation
bandwidth. `turns:` (TLS) and DTLS are in the `rstun-full-*` release assets and the container image.

## Install

```bash
brew install exvlan/rstun/rstun
```

## Upgrade

```bash
brew upgrade rstun
```

## Uninstall

```bash
brew uninstall rstun && brew untap exvlan/rstun
```

The formula is generated from the main repository on each release
(`script/ci/gen-brew.sh`); do not hand-edit pins here.
