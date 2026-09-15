# GENERATED — do not hand-edit.
#
# `dev/tools/package.py` in incoai/splash emits this file as dist/splash.rb
# when it builds a release archive. Publishing a release means copying that
# output over this one. The three placeholders below are the only difference
# between this and a real release: url, version and sha256.
class Splash < Formula
  desc "Local Qwen + DFlash server for Apple Silicon"
  homepage "https://github.com/incoai/splash"
  url "https://github.com/incoai/splash/releases/download/v0.0.0/splash-0.0.0.tar.gz"
  version "0.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    odie "Splash requires macOS 26.4 or newer." if MacOS.full_version < "26.4"
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

  test do
    assert_match "serve", shell_output("#{bin}/splash --help")
  end
end
