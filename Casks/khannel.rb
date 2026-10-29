cask "khannel" do
  version "1.0.0"
  sha256 "c8b7e204a1a919823749abd7d87433e86c47d79d417a7d9394fe7bd953694338"

  url "https://github.com/4BMtolobPL/khannel/releases/download/v#{version}/khannel-#{version}-macos-arm64.dmg"
  name "khannel"
  desc "IRC client built with GPUI"
  homepage "https://github.com/4BMtolobPL/khannel"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  app "khannel.app"

  zap trash: [
    "~/Library/Application Support/com.kimtalmo.khannel",
    "~/Library/Saved Application State/com.kimtalmo.khannel.savedState",
  ]

  caveats <<~EOS
    khannel is not notarized by Apple (ad-hoc signed), so macOS blocks the first launch.
    Open it once, then allow it in System Settings > Privacy & Security > "Open Anyway".
  EOS
end
