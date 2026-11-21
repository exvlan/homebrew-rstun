class Rstun < Formula
  desc "Standalone STUN/TURN server (RFC 5389, optional RFC 5780 and RFC 8656)"
  homepage "https://github.com/exvlan/rstun"
  version "26.410.103"
  license "MPL-2.0"

  if OS.mac?
    # Release 只出 macOS x86_64（无 arm64 产物）：Apple Silicon 上走 Rosetta 2。
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.103/rstun-macos-x86_64-26.410.103.zip"
    sha256 "643456c3636e9f220be402b55b381dbeeb57e9c1f9428021674bc68fa9eb8299"
  elsif Hardware::CPU.arm?
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.103/rstun-linux-aarch64-26.410.103.zip"
    sha256 "2569df386565bd7ca3864c45174bcdb89572afa4f0797b82f145b4ed9fd8e5a8"
  else
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.103/rstun-linux-x86_64-26.410.103.zip"
    sha256 "1c266f431383d4b792a43b11e24e50c2d34a8b58034c6df759ef9ecfca48f038"
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
