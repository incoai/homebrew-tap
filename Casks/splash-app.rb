cask "splash-app" do
  version "1.5.0"
  sha256 "f4e0540e9435e3a21643b265ac089e1baa4510ae3fab3649886d1611e7c3a330"

  url "https://github.com/incoai/splash/releases/download/#{version}/Splash-#{version}.dmg"
  name "Splash"
  desc "Local inference engine for Apple silicon, built around the model"
  homepage "https://github.com/incoai/splash"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Splash.app"

  uninstall quit: "ai.inco.splash"

  zap trash: [
    "~/Library/Application Support/Splash/Chats",
    "~/Library/Caches/ai.inco.splash",
    "~/Library/Caches/Splash",
    "~/Library/HTTPStorages/ai.inco.splash",
    "~/Library/Logs/Splash",
    "~/Library/Preferences/ai.inco.splash.plist",
    "~/Library/Saved Application State/ai.inco.splash.savedState",
    "~/Library/WebKit/ai.inco.splash",
  ]

  caveats "Splash needs an Apple M3 or newer and macOS 26.4 or later."
end
