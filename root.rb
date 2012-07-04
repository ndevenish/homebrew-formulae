require 'formula'

class Root < Formula
  homepage 'http://root.cern.ch'
  url 'ftp://root.cern.ch/root/root_v5.34.00.source.tar.gz'
  sha1 'e7c8352d92be8510b36001efb020f3eb0bf22ed1'
  version '5.34.00'
  keg_only "See Caveats; ROOT likes to be included through thisroot.sh"

  depends_on 'cmake' => :build

  def options
    [
      ['--cocoa', "Use the cocoa mode"],
      ['--minuit2', "Compile Minuit2"],
    ]
  end
  def install
    # Build out of source
    mkdir "cmake_oos"
    cd    "cmake_oos"
    # Extend the CMake arguments
    args = std_cmake_args
    args.push("-Dminuit2=ON") if ARGV.include? '--minuit2'
    args.push("-Dcocoa=ON") if ARGV.include? '--cocoa'

    system "cmake", "..", *args
    system "make install"

    if ARGV.include? '--cocoa'
      ln "#{prefix}/bin/root.exe" "#{prefix}/bin/root"
    end

  end

  def test
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test root`.
    system "false"
  end

  def patches
    # Fix the cocoa mode not compiling, due to a missing reference in the CMakeLists.txt
    DATA
  end

  def caveats; <<-EOS.undent
    Because ROOT depends on several installation-dependent
    environment variables to function properly, you should
    add the following commands to your shell initialization
    script (.bashrc/.profile/etc.), or call them directly
    before using ROOT.
  
    For csh/tcsh users:
      source #{prefix}/bin/thisroot.csh
    For bash/zsh users:
      . #{prefix}/bin/thisroot.sh
  
    EOS
  end
end

__END__
diff --git a/graf2d/cocoa/CMakeLists.txt b/graf2d/cocoa/CMakeLists.txt
index 556051c..a64acbf 100644
--- a/graf2d/cocoa/CMakeLists.txt
+++ b/graf2d/cocoa/CMakeLists.txt
@@ -5,6 +5,7 @@
 
 ROOT_USE_PACKAGE(graf2d/quartz)
 ROOT_USE_PACKAGE(gui/gui)
+ROOT_USE_PACKAGE(graf3d/gl)
 
 add_definitions("-ObjC++ -std=c++11")
 