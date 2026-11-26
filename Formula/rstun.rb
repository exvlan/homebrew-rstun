class Rstun < Formula
  desc "Standalone STUN/TURN server (RFC 5389, optional RFC 5780 and RFC 8656)"
  homepage "https://github.com/exvlan/rstun"
  version "26.410.107"
  license "MPL-2.0"

  if OS.mac?
    # Release 只出 macOS x86_64（无 arm64 产物）：Apple Silicon 上走 Rosetta 2。
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.107/rstun-macos-x86_64-26.410.107.zip"
    sha256 "d0d4b4f49a2073eea8c8930dcfb164a449e66c17206cb548d5394ef3af88938f"
  elsif Hardware::CPU.arm?
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.107/rstun-linux-aarch64-26.410.107.zip"
    sha256 "165228951ce9942e857d477d2681bfe3eb872c7182e2c6eac227d08d2100984c"
  else
    url "https://github.com/exvlan/rstun/releases/download/rstun-v26.410.107/rstun-linux-x86_64-26.410.107.zip"
    sha256 "4832588f00cb9ef2f497708c2b3061e76038a277d799481596bc16bd50b269f4"
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
