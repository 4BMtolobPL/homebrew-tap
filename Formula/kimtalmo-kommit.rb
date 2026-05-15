class KimtalmoKommit < Formula
  desc "CLI tool using AI to generate Conventional Commits from Git diffs"
  homepage "https://github.com/4BMtolobPL/kommit"
  url "https://github.com/4BMtolobPL/kommit/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2dda078bc3324213699fd333579be1b90d5217bdde174793495cf6a326856167"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "./kommit")
  end

  test do
    assert_match "kommit", shell_output("#{bin}/kommit --help", 2)
  end
end
