class Rstun < Formula
  desc "Standalone STUN/TURN server (RFC 5389, optional RFC 5780 and RFC 8656)"
  homepage "https://github.com/exvlan/rstun"
  version "26.410.102"
  license "MPL-2.0"

  if OS.mac?
    # Release 只出 macOS x86_64（无 arm64 产物）：Apple Silicon 上走 Rosetta 2。
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.102/rstun-macos-x86_64-26.410.102.zip"
    sha256 "2fc521f041b26df92301820646289c6500c59718012c063cc51b8a1de8a6cc0a"
  elsif Hardware::CPU.arm?
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.102/rstun-linux-aarch64-26.410.102.zip"
    sha256 "a5be12c6b05d5bca71fee28d813ee78d2bfede3a77f96ef14a6afddbe29395e0"
  else
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.102/rstun-linux-x86_64-26.410.102.zip"
    sha256 "4e109666aebe15189229e7de2f3396a5ab0a9d35c8fe696f13d751ce5c2b7f53"
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
