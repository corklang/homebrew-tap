class Corklang < Formula
  desc "Programming language that compiles to Commodore 64 machine code"
  homepage "https://github.com/corklang/cork"
  url "https://github.com/corklang/cork/archive/refs/tags/0.1.0.tar.gz"
  sha256 "b8ab04af2d1a667eb8799b3f229dad511e0ba60a2b4e57cd567bb968a4bafe13"
  license "MIT"

  depends_on "dotnet"

  def install
    system "dotnet", "publish", "src/Cork.Compiler",
           "-c", "Release",
           "-o", buildpath/"out",
           "/p:Version=#{version}"
    bin.install buildpath/"out/Cork.Compiler" => "cork"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cork --version")
  end
end
