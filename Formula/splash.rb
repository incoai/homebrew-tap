class SplashMacOSRequirement < Requirement
  fatal true
  satisfy(build_env: false) { OS.mac? && MacOS.full_version >= "26.4" }

  def message
    "Splash requires macOS 26.4 or newer."
  end
end

class Splash < Formula
  desc "Local inference engine for Apple silicon, built around the model"
  homepage "https://github.com/incoai/splash"
  url "https://github.com/incoai/splash/releases/download/1.3.1/splash-1.3.1-arm64-macos26.tar.gz"
  sha256 "f98c602b16a70a7bc01e05b3a9e6034c367aedd47e11a4c63b637d1342756c92"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/incoai/splash/releases/download/1.3.1"
    sha256 cellar: :any, arm64_tahoe: "296c416b34a8cc023420ac920fb757ab72ffe6bc45b8345190b6a5495ed0a875"
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe
  depends_on SplashMacOSRequirement

  def install
    libexec.install Dir["*"]
    (bin/"splash").write <<~SH
      #!/bin/sh
      export PYTHONDONTWRITEBYTECODE=1
      exec "#{opt_libexec}/python/bin/python3" -u "#{opt_libexec}/install/launcher.py" "$@"
    SH
    chmod 0755, bin/"splash"
    zsh_completion.install_symlink libexec/"install/completions/_splash"
    bash_completion.install_symlink libexec/"install/completions/splash.bash" => "splash"
    fish_completion.install_symlink libexec/"install/completions/splash.fish"
  end

  def caveats
    <<~CAVEAT
      Serve a model:
        splash serve --model unsloth/Qwen3.8-27B-GGUF:UD-Q4_K_M
    CAVEAT
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/splash --version")
    assert_match "serve", shell_output("#{bin}/splash --help")
  end
end
