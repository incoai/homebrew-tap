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
  url "https://github.com/incoai/splash/releases/download/1.0.1/splash-1.0.1-arm64-macos26.tar.gz"
  sha256 "67f58adcb6266208bf072c2c58631e957949120a66e33d03ad2a036de98aefb0"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/incoai/splash/releases/download/1.0.1"
    sha256 cellar: :any, arm64_tahoe: "5e313f34da21b9b36427ff6e28a457af2fd674af7605414f141af259a854a5f9"
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
    CAVEAT
  end

  service do
    run ["/bin/sh", "-c", <<~SH]
      set -eu
      SPLASH_MODEL=incoai/Qwen3.8-27B-Splash
      SPLASH_PORT=8000
      if [ -f "#{etc}/splash-service.conf" ]; then
        . "#{etc}/splash-service.conf"
      fi
      exec "#{opt_bin}/splash" serve --model "$SPLASH_MODEL" --port "$SPLASH_PORT" "$@"
    SH
    keep_alive true
    log_path var/"log/splash.log"
    error_log_path var/"log/splash.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/splash --version")
    assert_match "serve", shell_output("#{bin}/splash --help")
  end
end
