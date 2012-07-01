require 'formula'

class Msrt < Formula
  homepage 'http://www-numi.fnal.gov/offline_software/srt_public_context/WebDocs/msrt.html'
  head 'cvs://:pserver:anonymous:anoncvs@minoscvs.fnal.gov:/cvs/minoscvs/rep1:setup/msrt'
  sha1 '8dd80f582149052c87907f675ec3089fc3dc7a2d'

  def install
    # Build the man page from help
    system "./msrt help > msrt.1"
    inreplace 'msrt.1' do |s| 
      # Make the section headers, section headers
      s.gsub! /^(?=[^\s])/, '.SH '
      # Add the header
      s.insert(0,".TH MSRT 1 \"\" \"\" \"User Manuals\"\n")
      # s.gsub! /^\s{4}(?=msrt.*$)/, '.IP '
      # Replace the command options with italics
      s.gsub! /\[\s?(-[^\]]+?)\s(.+?)\]/, "\n.B [ \\1\n.I \\2\n.B ]"
      # And the command switches with bold
      s.gsub! /\[\s?(-[^\]]+?)\]/, "\n.B [\\1]"
      # Make the msrt lines bold
      s.gsub! /^ {4}msrt (.+?)(?=\s)/, "\n.B msrt \\1"
      # Replace the rogue <>
      s.gsub! /^(\s+)<compiler_label>/, "\\1compiler_label"
      # Any bold <> should be italic, and tidy the ]
      s.gsub! /(<.+?>)(?=\s)/, "\n.I \\1"
      s.gsub! />\s\]/, ">\n.B ]"
      # Italicise optional positional parameters
      s.gsub! /\[([^\s-].+)\]/, "[\n.I \\1\n.B ]"

      # Align the 12-step numbers
      s.gsub! /\s+(\d+)\)/, "\n.IP \\1)\n"
      # Merge the paragraphs in the 12-step - rely on the 
      # fact that someone inserted tabs there
      s.gsub! /^\t/, " "
      # And, add an extra indentation for the next periods
      s.gsub! /\t(.+)/, "\n.RS\n\\1\n.RE\n"
      # escape the lone \
      s.gsub! /\\/, "\\\\\\\\"
    end

    man1.install "msrt.1"
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

