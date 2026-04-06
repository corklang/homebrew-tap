class Corklang < Formula
  desc "Programming language that compiles to Commodore 64 machine code"
  homepage "https://github.com/corklang/cork"
  url "https://github.com/corklang/cork/archive/refs/tags/0.2.0.tar.gz"
  sha256 "c2c069d62f82a4cb0cf42dc4277293bce7918dddf8ee5d9caf4a327459dede47"
  license "MIT"

  depends_on "dotnet"

  def install
    system "dotnet", "publish", "src/Cork.Compiler",
           "-c", "Release",
           "-o", buildpath/"out",
           "/p:Version=#{version}"
    bin.install buildpath/"out/Cork.Compiler" => "cork"
    (share/"corklang/stdlib").install Dir["stdlib/*.cork"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cork --version")
  end
end
