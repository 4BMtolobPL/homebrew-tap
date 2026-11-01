cask "khannel" do
  version "1.0.1"
  sha256 "5bb31d8da9e2efa93ae25505894e295dd36f25c09f6066a39b8e2e0fd7c604c6"

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
