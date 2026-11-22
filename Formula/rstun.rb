class Rstun < Formula
  desc "Standalone STUN/TURN server (RFC 5389, optional RFC 5780 and RFC 8656)"
  homepage "https://github.com/exvlan/rstun"
  version "26.410.104"
  license "MPL-2.0"

  if OS.mac?
    # Release 只出 macOS x86_64（无 arm64 产物）：Apple Silicon 上走 Rosetta 2。
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.104/rstun-macos-x86_64-26.410.104.zip"
    sha256 "40eab92114cefcc07062d37c64fc604ad1b911d36b50b1e058c1a0e31975ffac"
  elsif Hardware::CPU.arm?
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.104/rstun-linux-aarch64-26.410.104.zip"
    sha256 "22139a70d0ed00802a503fc96704fc329e2e4c4882c29224556be96be3229c6e"
  else
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.104/rstun-linux-x86_64-26.410.104.zip"
    sha256 "814fafa686403edce5340c926d0d124d3a44a6e2caa5abd836ba10792410dc3e"
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
