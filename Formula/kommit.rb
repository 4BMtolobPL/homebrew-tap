class Kommit < Formula
  desc "CLI tool using AI to generate Conventional Commits from Git diffs"
  homepage "https://github.com/4BMtolobPL/kommit"
  version "0.2.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/4BMtolobPL/kommit/releases/download/v0.2.0/kommit-aarch64-apple-darwin.tar.xz"
    sha256 "4da5ed9238c8637ce6cc98c02687656ed0db1db945d96243b5b2c312d7af1191"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/4BMtolobPL/kommit/releases/download/v0.2.0/kommit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4ece3e6583e05c251d25131b27a101f36248a58f6359a78ca96dd9071677aa3c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/4BMtolobPL/kommit/releases/download/v0.2.0/kommit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d3df95f24c3f5e70a99aabd6da201a327464b07ba9cc5d7bc88205ef09c31ab6"
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
