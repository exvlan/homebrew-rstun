class Rstun < Formula
  desc "Standalone STUN/TURN server (RFC 5389, optional RFC 5780 and RFC 8656)"
  homepage "https://github.com/exvlan/rstun"
  version "26.410.106"
  license "MPL-2.0"

  if OS.mac?
    # Release 只出 macOS x86_64（无 arm64 产物）：Apple Silicon 上走 Rosetta 2。
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.106/rstun-macos-x86_64-26.410.106.zip"
    sha256 "71e975aa1731629492389f475a923b6d2d066e5aad53e7e48fa9fcb5a1f1f441"
  elsif Hardware::CPU.arm?
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.106/rstun-linux-aarch64-26.410.106.zip"
    sha256 "14c21f875f86908adbf681f636a2843da1c88a4baaebee4b1fc3575b20b3422f"
  else
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.106/rstun-linux-x86_64-26.410.106.zip"
    sha256 "b664f275191c73489e6fd502db2cc5d923f6f5d5d7aad519151c0d65122dd85e"
  end

  def install
    bin.install "rstun"
  end

  def caveats
    <<~EOS
      这是 lean 构建：STUN + TURN(UDP/TCP) + TURN REST 临时凭据 + 带宽配额。
      要 turns:(TLS) 与 DTLS，用 Release 的 rstun-full-<platform>-<version>.zip，
      或容器镜像 ghcr.io/exvlan/rstun（full 构建）。
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rstun --version")
    assert_match "--turn-bandwidth", shell_output("#{bin}/rstun server --help")
  end
end
