# typed: false
# frozen_string_literal: true

# Splash — Inco AI's inference engine for Apple silicon.
#
# NOT YET PUBLISHABLE. `version`, `url` and `sha256` are placeholders: as of
# writing, incoai/splash has no tags and no releases. See README.md for the
# checklist that turns this into a working formula.
class Splash < Formula
  desc "Local inference engine for coding agents on Apple silicon"
  homepage "https://github.com/incoai/splash"
  license "Apache-2.0"

  # TODO(release): set from the git tag on incoai/splash.
  version "0.0.0"

  # Metal kernels are built for Apple GPU family 9 and newer, so M3 at minimum.
  depends_on arch: :arm64
  # :tahoe is macOS 26. Homebrew cannot express a patch floor; the engine
  # itself requires 26.4+ and checks at startup.
  depends_on macos: :tahoe

  on_macos do
    # TODO(release): point at the release asset and its real digest.
    url "https://github.com/incoai/splash/releases/download/v0.0.0/splash-darwin-arm64.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"

    def install
      bin.install "splash"
      # Shipped in incoai/splash under install/completions. Confirm the release
      # tarball actually carries them before uncommenting.
      # bash_completion.install "completions/splash.bash" => "splash"
      # zsh_completion.install "completions/_splash"
    end
  end

  def caveats
    <<~EOS
      Splash serves a curated roster of models. Start the server with:
        splash serve --model incoai/Qwen3.8-27B-Splash

      The first run downloads and verifies the model package, which is large.
      48 GB of unified memory or more is recommended; 36 GB is the minimum.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/splash --version")
  end
end
