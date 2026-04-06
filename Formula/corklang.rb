class Corklang < Formula
  desc "Programming language that compiles to Commodore 64 machine code"
  homepage "https://github.com/corklang/cork"
  url "https://github.com/corklang/cork/archive/refs/tags/0.3.0.tar.gz"
  sha256 "78bbcf43e9211558d5f0abf68918db96a2bebf6f766cd04d8bcb793e83500c2d"
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
