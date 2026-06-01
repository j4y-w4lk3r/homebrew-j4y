class J4ySuite < Formula
  desc "Meta-formula installing the j4y-w4lk3r personal CLI suite"
  homepage "https://github.com/j4y-w4lk3r"
  url "https://github.com/j4y-w4lk3r/homebrew-j4y/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "b2871c8a5494f381752fedb33c4203877cdf0ded434d7139b199cf76e2b46e96"
  license "MIT"
  version "0.1.0"

  # The actual install work is the dependency chain. Each line below
  # tells brew "make sure this is on disk before completing my install".
  # `brew install j4y-w4lk3r/j4y/j4y-suite` therefore chain-installs the
  # whole suite from one command. After install, each tool stays on its
  # own release cadence — the meta-formula does NOT pin dep versions.
  #
  # Formulas (CLI binaries / shell scripts):
  depends_on "j4y-w4lk3r/rui/rui"
  depends_on "j4y-w4lk3r/ykw/ykw"
  depends_on "j4y-w4lk3r/bbm/bbm"
  # Cask (unsigned macOS binary, ships via goreleaser homebrew_casks):
  depends_on cask: "j4y-w4lk3r/fsvc/fsvc"

  def install
    # Tiny status helper — `j4y-suite version` lists what's installed.
    # Heredoc keeps the formula self-contained; no extra files needed
    # in the tap repo source tree.
    (bin/"j4y-suite").write <<~EOS
      #!/bin/bash
      # j4y-suite — status helper for the j4y-w4lk3r CLI suite

      META_VERSION="#{version}"

      cmd=${1:-version}
      case "$cmd" in
        version|-v|--version|status)
          echo "j4y-suite ${META_VERSION}"
          echo
          echo "Installed tools:"
          for t in rui ykw bbm fsvc; do
            if path=$(command -v "$t" 2>/dev/null); then
              # Each tool reports its own version slightly differently;
              # try common flags and fall back to "(installed)".
              v=$("$t" -v 2>/dev/null || "$t" --version 2>/dev/null || echo "(installed)")
              # Trim to first line for tidy output.
              v=$(printf '%s' "$v" | head -n 1)
              printf "  %-8s %s   %s\\n" "$t" "$v" "$path"
            else
              printf "  %-8s (not on PATH)\\n" "$t"
            fi
          done
          ;;
        help|-h|--help)
          cat <<'HELP'
      Usage:
        j4y-suite [version|status]   show meta-version + each tool's version
        j4y-suite help               this message

      The suite is installed and upgraded via Homebrew:
        brew install   j4y-w4lk3r/j4y/j4y-suite
        brew upgrade   j4y-w4lk3r/rui/rui   j4y-w4lk3r/ykw/ykw \\
                       j4y-w4lk3r/bbm/bbm   j4y-w4lk3r/fsvc/fsvc
      HELP
          ;;
        *)
          echo "j4y-suite: unknown subcommand: $cmd" >&2
          echo "try: j4y-suite help" >&2
          exit 2
          ;;
      esac
    EOS
    chmod 0755, bin/"j4y-suite"
  end

  test do
    # Sanity: the helper script runs and emits the expected version line.
    assert_match "j4y-suite #{version}", shell_output("#{bin}/j4y-suite version")
  end
end
