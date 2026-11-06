cask "splash-app" do
  version "1.6.0"
  sha256 "fedb0591baee522911c0c414217f8963bfa7ded8f30d1388db6dd976ece0075c"

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
