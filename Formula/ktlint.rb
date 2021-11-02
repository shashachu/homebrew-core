class Ktlint < Formula
  desc "Anti-bikeshedding Kotlin linter with built-in formatter"
  homepage "https://ktlint.github.io/"
  url "https://github.com/pinterest/ktlint/releases/download/0.43.0/ktlint"
  sha256 "5a20f69278da5a2d2b869ff06972291ca4b7811cf72f962192f1716e71ed2e6f"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "b5fd1bf8b64e48fc322995ae098c1ed63818fd4d344f56368466c211e20c6cc9"
  end

  depends_on "openjdk@11"

  def install
    libexec.install "ktlint"
    (libexec/"ktlint").chmod 0755
    (bin/"ktlint").write_env_script libexec/"ktlint", JAVA_HOME: Formula["openjdk@11"].opt_prefix
  end

  test do
    (testpath/"In.kt").write <<~EOS
      fun main( )
    EOS
    (testpath/"Out.kt").write <<~EOS
      fun main()
    EOS
    system bin/"ktlint", "-F", "In.kt"
    assert_equal shell_output("cat In.kt"), shell_output("cat Out.kt")
  end
end
