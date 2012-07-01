require 'formula'

class Msrt < Formula
  homepage 'http://www-numi.fnal.gov/offline_software/srt_public_context/WebDocs/msrt.html'
  head 'cvs://:pserver:anonymous:anoncvs@minoscvs.fnal.gov:/cvs/minoscvs/rep1:setup/msrt'
  sha1 '8dd80f582149052c87907f675ec3089fc3dc7a2d'

  def install
    bin.install "msrt"
  end

  def patches
    # Remove the completely unnecessary "type" prompts
    DATA
  end
end

__END__
diff --git a/msrt b/msrt
index 0918a21..02dc2f9 100755
--- a/msrt
+++ b/msrt
@@ -10,9 +10,9 @@
 
 # Some hard coded values unlikely to change very frequently:
 
-srt_cvsroot=":pserver:anonymous@cdcvs.fnal.gov:/srtcvs"
+srt_cvsroot=":pserver:anonymous:anoncvs@cdcvs.fnal.gov:/srtcvs"
 
-cvsroot_pserver=":pserver:anonymous@minoscvs.fnal.gov:/cvs/minoscvs/rep1"
+cvsroot_pserver=":pserver:anonymous:anoncvs@minoscvs.fnal.gov:/cvs/minoscvs/rep1"
 cvsroot_ssh="minoscvs@minoscvs.fnal.gov:/cvs/minoscvs/rep1"
 
 ########################################################################
@@ -414,9 +414,6 @@ anoncvs () {
 
     grep -q $cvsroot $HOME/.cvspass > /dev/null 2>&1
     if [ $? -ne 0 ] ; then
-	echo
-	echo "Please type \"anoncvs\" at the \"CVS password:\" prompt."
-	echo
         cvs -d $cvsroot login
     fi
     if [ $? != 0 ] ; then 

