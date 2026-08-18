class Mailersend < Formula
  desc "Command-line interface for the MailerSend API"
  homepage "https://github.com/mailersend/mailersend-cli"
  version "2.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mailersend/mailersend-cli/releases/download/v2.0.0/mailersend-aarch64-apple-darwin.tar.gz"
      sha256 "d7036cf7d22763ef94bbb4e7365df85b162ea7b62188f7aaca2f54b84a162f95"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mailersend/mailersend-cli/releases/download/v2.0.0/mailersend-x86_64-apple-darwin.tar.gz"
      sha256 "10739ea9f10417566003eabb02148af9bba985481e2e76b38967dd96f2fd45ec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mailersend/mailersend-cli/releases/download/v2.0.0/mailersend-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ba27f6c2f3f79421d7a35ee4651173c50cf2f1437bd730c0f2472b0cf75f7879"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mailersend/mailersend-cli/releases/download/v2.0.0/mailersend-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4a1e6d74e16b9a2446c242ff5ac42ae2f8d2c985e09d99e3fb9de1174714916c"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
      bin.install "mailersend"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mailersend"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mailersend"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mailersend"
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
