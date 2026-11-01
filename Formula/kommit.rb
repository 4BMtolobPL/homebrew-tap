class Kommit < Formula
  desc "CLI tool using AI to generate Conventional Commits from Git diffs"
  homepage "https://github.com/4BMtolobPL/kommit"
  version "0.1.5"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/4BMtolobPL/kommit/releases/download/v0.1.5/kommit-aarch64-apple-darwin.tar.xz"
    sha256 "7d19bae10fd4dca40112a645499209406b300bd76a89a0e2a9baf6c33843f857"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/4BMtolobPL/kommit/releases/download/v0.1.5/kommit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3bde45594f142cc6e2d09e337919297558ecc3687e17920b7c0576407b341ffc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/4BMtolobPL/kommit/releases/download/v0.1.5/kommit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c96ae691cf8301f8c413a66a584fc6b0c8b313f3ac1ba8cf556fcd5d1214acfd"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "kommit"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kommit"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kommit"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
