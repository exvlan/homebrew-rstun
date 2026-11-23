class Rstun < Formula
  desc "Standalone STUN/TURN server (RFC 5389, optional RFC 5780 and RFC 8656)"
  homepage "https://github.com/exvlan/rstun"
  version "26.410.105"
  license "MPL-2.0"

  if OS.mac?
    # Release 只出 macOS x86_64（无 arm64 产物）：Apple Silicon 上走 Rosetta 2。
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.105/rstun-macos-x86_64-26.410.105.zip"
    sha256 "6b54aa676bdac0df4f22005c4cc2d60d93414af994cd2d73169e0422e0ba9831"
  elsif Hardware::CPU.arm?
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.105/rstun-linux-aarch64-26.410.105.zip"
    sha256 "9707091529ae1b1bc90f88760ab62d10842638f1ed6cc3f4222f9616eec1f70a"
  else
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.105/rstun-linux-x86_64-26.410.105.zip"
    sha256 "ed7c29f8177ae8aa83141c86240c6d3e59dc8efe36781565739e294706423ecc"
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
