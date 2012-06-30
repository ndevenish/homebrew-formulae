require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Root < Formula
  homepage 'http://root.cern.ch'
  url 'ftp://root.cern.ch/root/root_v5.34.00.source.tar.gz'
  sha1 'e7c8352d92be8510b36001efb020f3eb0bf22ed1'
  version '5.34.00'
  keg_only "See Caveats; ROOT likes to be included through thisroot.sh"

  depends_on 'cmake' => :build

  def install
    # ENV.x11 # if your formula requires any X11 headers
    # ENV.j1  # if your formula's build system can't parallelize

    # Build out of source
    mkdir "cmake_oos"
    cd    "cmake_oos"
    system "cmake", "..", *std_cmake_args
    system "make"
    system "make install" # if this fails, try separate make/make install steps
  end

  def test
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test root`.
    system "false"
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
