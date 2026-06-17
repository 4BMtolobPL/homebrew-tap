class KimtalmoKommit < Formula
  desc "CLI tool using AI to generate Conventional Commits from Git diffs"
  homepage "https://github.com/4BMtolobPL/kommit"
  url "https://github.com/4BMtolobPL/kommit/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "56fe2b332f32c7a289d4ce65a7682e0192774b9d3dd00760b5c5ba6157807429"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "./kommit")
  end

  test do
    assert_match "kommit", shell_output("#{bin}/kommit --help", 2)
  end
end
