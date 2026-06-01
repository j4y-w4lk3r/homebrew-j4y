# homebrew-j4y

Meta-tap for the [`j4y-w4lk3r`](https://github.com/j4y-w4lk3r) personal CLI suite.

Installs the whole suite in one command:

```bash
brew install --cask j4y-w4lk3r/j4y/j4y-suite
```

Why a Cask, not a Formula? Brew formulas are not allowed to depend on casks. Since `fsvc` ships as a cask (it's an unsigned binary that needs the Gatekeeper-strip post-install hook), the meta-package itself has to be a cask too. Casks can depend on both casks and formulas, so this works cleanly.

That pulls in (chain-installed via `depends_on`):

| Tool   | Type    | What it does                                                 | Tap                            |
| ------ | ------- | ------------------------------------------------------------ | ------------------------------ |
| `rui`  | formula | Orange Livebox / Funbox router TUI                           | `j4y-w4lk3r/rui`               |
| `ykw`  | formula | YubiKey-backed GPG encrypt/decrypt + 1Password audit logging | `j4y-w4lk3r/ykw`               |
| `bbm`  | formula | Backblaze B2 manager (push, pull, ls, sync, encrypt-bundles) | `j4y-w4lk3r/bbm`               |
| `fsvc` | cask    | Financial-services CLI (Revolut Business mTLS+JWT+OAuth)     | `j4y-w4lk3r/fsvc`              |

Future additions (when their taps ship): `bmcctl` (Redfish/IPMI server management), `pikvm` (PiKVM helpers).

## Why a meta-tap?

The individual tools are independently versioned and shipped — the meta-cask is just a one-liner convenience for fresh installs. After install, `brew upgrade` continues to update each tool on its own release cadence; the meta-cask does not pin versions of its dependencies.

## Verify

```bash
j4y-suite version    # prints the meta-version + each installed tool's version
```

## License

MIT — see [`LICENSE`](LICENSE).
