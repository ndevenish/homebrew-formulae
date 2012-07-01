require 'formula'

class Msrt < Formula
  homepage 'http://www-numi.fnal.gov/offline_software/srt_public_context/WebDocs/msrt.html'
  # head ':pserver:anonymous:anoncvs@minoscvs.fnal.gov/cvs/minoscvs/rep1 /setup/msrt', :using => :cvs
  head 'cvs://:pserver:anonymous:anoncvs@minoscvs.fnal.gov:/cvs/minoscvs/rep1:setup/msrt'
       # 'cvs://:pserver:anonymous@chmox.cvs.sourceforge.net:/cvsroot/chmox:Sources'
  sha1 '8dd80f582149052c87907f675ec3089fc3dc7a2d'

  def install
    bin.install "msrt"
  end

  def test
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test root`.
    system "false"
  end

end
