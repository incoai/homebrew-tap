class SplashOmniMacOSRequirement < Requirement
  fatal true
  satisfy(build_env: false) { OS.mac? && MacOS.full_version >= "26.4" }

  def message
    "Splash Omni requires macOS 26.4 or newer."
  end
end

class SplashOmni < Formula
  desc "Local speech engine for Apple silicon, built around the model"
  homepage "https://github.com/incoai/splash-omni"
  url "https://github.com/incoai/splash-omni/releases/download/1.0.0/splash-omni-1.0.0-arm64-macos26.tar.gz"
  sha256 "4b2278927d50c200727869d656b8fe7bd6502d30b7ab916efc280ad9a1d6a5b7"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/incoai/splash-omni/releases/download/1.0.0"
    sha256 arm64_golden_gate: "ce9130b6e96134cd1361935325ccacecae7dad9153aac49cca2963b91140417e"
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe
  depends_on SplashOmniMacOSRequirement

  def install
    libexec.install Dir["*"]
    (bin/"splash-omni").write <<~SH
      #!/bin/sh
      export PYTHONDONTWRITEBYTECODE=1
      exec "#{opt_libexec}/python/bin/python3" -u "#{opt_libexec}/install/launcher.py" "$@"
    SH
    chmod 0755, bin/"splash-omni"
    zsh_completion.install_symlink libexec/"install/completions/_splash-omni"
    bash_completion.install_symlink libexec/"install/completions/splash-omni.bash" => "splash-omni"
    fish_completion.install_symlink libexec/"install/completions/splash-omni.fish"
  end

  def caveats
    <<~CAVEAT
      Serve a model:
        splash-omni serve --model mlx-community/Qwen3-TTS-12Hz-1.7B-Base-4bit
      Or choose the model and try it in a browser:
        splash-omni ui
    CAVEAT
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/splash-omni --version")
    assert_match "serve", shell_output("#{bin}/splash-omni --help")
  end
end
