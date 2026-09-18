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
  url "https://github.com/incoai/splash/releases/download/1.0/splash-1.0-arm64-macos26.tar.gz"
  sha256 "0a4d795518d001564889f348c75723ecd0a14067d8d564a0aec17c4a3898999b"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/incoai/splash/releases/download/1.0"
    sha256 cellar: :any, arm64_tahoe: "b8ccef6c41ed9061968a74209f9851eab53d27fcc1d2fe68e491d7a9b45db145"
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
  end

  def caveats
    <<~CAVEAT
      Serve a model:
        splash serve --model incoai/Qwen3.8-27B-Splash

      If `splash serve --model <TAB>` offers nothing, zsh cannot see Homebrew's
      completions. Add this to ~/.zshrc, before compinit runs:
        FPATH="#{HOMEBREW_PREFIX}/share/zsh/site-functions:$FPATH"
      then: rm -f ~/.zcompdump*; exec zsh
    CAVEAT
  end

  test do
    assert_match "serve", shell_output("#{bin}/splash --help")
  end
end
