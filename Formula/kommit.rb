class Kommit < Formula
  desc "CLI tool using AI to generate Conventional Commits from Git diffs"
  homepage "https://github.com/4BMtolobPL/kommit"
  version "0.1.3"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/4BMtolobPL/kommit/releases/download/v0.1.3/kommit-aarch64-apple-darwin.tar.xz"
    sha256 "bceeaa74f026df494f41e58fef9954abd0e03cf9a33667ae51a374c399b21202"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/4BMtolobPL/kommit/releases/download/v0.1.3/kommit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c3a8cd96288f559f372c33c147d513b7d70fe2db149fac5502abc9fdcabe3e0b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/4BMtolobPL/kommit/releases/download/v0.1.3/kommit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a0369b4e592b4d021d3f0817850950da7a6d1f0e75aa23af5f1656bcac649087"
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
    bin.install "kommit" if OS.mac? && Hardware::CPU.arm?
    bin.install "kommit" if OS.linux? && Hardware::CPU.arm?
    bin.install "kommit" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
