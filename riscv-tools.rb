require "formula"

class RiscvTools < Formula
  homepage "http://riscv.org"
  url "https://github.com/riscv/riscv-tools/archive/homebrew.tar.gz"
  sha256 "cb919eb7cf11071c6d11c721a9e77893a2dbe9158466e444eb3dd8476a89b7b4"
  version "0.1"

  # install rest of tools
  depends_on "riscv-fesvr"
  depends_on "riscv-isa-sim"
  depends_on "riscv-gcc"
  depends_on "riscv-pk"

  def install
    prefix.install "build.common"
    # not needed, but used to prevent formula being marked as empty
  end

  test do
    hello = "hello"
    (testpath/'hello.c').write("#include <stdio.h>
int main() {
  printf(\"#{hello}\");
  return 0;
}")
    system "riscv64-unknown-elf-gcc", (testpath/'hello.c')
    assert_equal hello, shell_output("spike pk #{testpath}/a.out")
  end
end
