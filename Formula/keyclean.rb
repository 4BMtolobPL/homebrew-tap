class Keyclean < Formula
  desc "Small utility to clean your Macbook keyboard"
  homepage "https://github.com/4BMtolobPL/Keyclean"
  url "https://github.com/4BMtolobPL/Keyclean/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "dbf389a85ce18f63e72a66eeef361ae3ababefaa4f1ca670258b0050a41951c1"
  license ""

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_path_exists bin/"keyclean"
    assert_predicate bin/"keyclean", :executable?
  end
end
