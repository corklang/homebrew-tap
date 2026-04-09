class DotnetRequirement < Requirement
  fatal true
  download "https://dotnet.microsoft.com/download"

  satisfy(build_env: false) { which("dotnet") }

  def message
    "corklang requires the .NET SDK to build.\n" \
      "Install with: brew install dotnet\n" \
      "Or download from: https://dotnet.microsoft.com/download"
  end
end

class Corklang < Formula
  desc "Programming language that compiles to Commodore 64 machine code"
  homepage "https://github.com/corklang/cork"
  url "https://github.com/corklang/cork/archive/refs/tags/0.3.1.tar.gz"
  sha256 "2d002b630ed3839d7d67016a74ac1a02b36fd2f795c31c90a8ad97b92c58a31e"
  license "MIT"

  depends_on DotnetRequirement

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
