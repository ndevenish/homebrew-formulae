require 'formula'

class Msrt < Formula
  homepage 'http://www-numi.fnal.gov/offline_software/srt_public_context/WebDocs/msrt.html'
  head 'cvs://:pserver:anonymous:anoncvs@minoscvs.fnal.gov:/cvs/minoscvs/rep1:setup/msrt'
  sha1 '8dd80f582149052c87907f675ec3089fc3dc7a2d'

  def install
    bin.install "msrt"
  end

end
