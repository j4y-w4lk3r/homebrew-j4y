cask "j4y-suite" do
  version "0.2.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/j4y-w4lk3r/homebrew-j4y/archive/refs/tags/v#{version}.tar.gz"
  name "j4y-suite"
  desc "Meta-cask installing the j4y-w4lk3r personal CLI suite"
  homepage "https://github.com/j4y-w4lk3r"

  # The actual install work is the dependency chain. brew chain-installs
  # each tool from its own tap when you `brew install j4y-suite`. After
  # that, every tool stays on its own release cadence — the meta-cask
  # does NOT pin dep versions.
  #
  # Casks (unsigned macOS binaries shipped via goreleaser homebrew_casks):
  depends_on cask: "j4y-w4lk3r/fsvc/fsvc"
  depends_on cask: "j4y-w4lk3r/bmcctl/bmcctl"
  # Formulas (CLI binaries / shell scripts):
  depends_on formula: "j4y-w4lk3r/rui/rui"
  depends_on formula: "j4y-w4lk3r/ykw/ykw"
  depends_on formula: "j4y-w4lk3r/bbm/bbm"

  # Drop the j4y-suite status helper onto $PATH. The path inside the
  # downloaded tarball is `homebrew-j4y-<version>/bin/j4y-suite` because
  # GitHub prefixes archive contents with `<repo>-<ref>/`.
  binary "homebrew-j4y-#{version}/bin/j4y-suite"

  # Casks don't auto-clean files installed via `binary`, but uninstalling
  # the cask removes the symlink. The script itself lives in the Caskroom
  # (managed by brew). No extra `uninstall` block needed.
end
