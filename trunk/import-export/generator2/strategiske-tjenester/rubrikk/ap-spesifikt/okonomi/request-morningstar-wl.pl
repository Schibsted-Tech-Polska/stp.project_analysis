#!/usr/bin/perl
use Net::SFTP::Foreign;
use FindBin qw($Bin);
use XML::Simple;
use LWP::Simple;
use Net::SCP;
use File::Copy;
use XML::LibXSLT;
use XML::LibXML;
use warnings;
my $winnersUrl="";
my $losersUrl="";
sub xsltprocfast{
  my $readfn=shift;
  my $writefn=shift;
  my $xslfile="/home/mno/strategiske-tjenester/rubrikk/ap-spesifikt/okonomi/wl.xsl";
  my $parser=XML::LibXML->new();
  my $xslt=XML::LibXSLT->new();
	my $style_doc=$parser->parse_file($xslfile);
	if ($@){
		print "Could not create an instance of the XSL processor using $xslfile:\n";
		print $@;
		return(0);
	}
	my $source = $parser->parse_file($readfn);
	if ($@) {
		print "Could not load XML file $readfn:\n";
		print $@;
		return(0);
	}
	my $stylesheet = $xslt->parse_stylesheet($style_doc);
	my $results = $stylesheet->transform($source);
	if ($@) {
		print "Could not transform XML file $readfn:\n";
		print $@;
		return(0);
	}
	print $results->toString;
	open(NEW, ">$writefn");
	print NEW $results->toString;
	close(NEW);
	return(1);
}
sub handlexsltfast{
	my $fn = shift;
	my $tmpfn = $fn . ".tmp";
        print "Attempting XSLT processing of $fn\n";
	if (xsltprocfast($fn, $tmpfn)) {
		print "XSLT processing worked.\n";
		copy($tmpfn, $fn);
		unlink($tmpfn);
	} else {
		print "XSLT processing failed.\n";
		mkdir("failed") unless (-d "failed");
		move($fn, "failed/$fn");
	}
}
my $f="/home/mno/strategiske-tjenester/rubrikk/ap-spesifikt/okonomi/current-wl.morningstar";
my $fn="/home/mno/strategiske-tjenester/rubrikk/ap-spesifikt/okonomi/morningstar-wl-pre-request.xml";
my $TID2 = localtime(time);
open LOGFILE, ">>/home/mno/strategiske-tjenester/rubrikk/ap-spesifikt/okonomi/import.log";
print LOGFILE "$TID2: SCRIPT KJOERT\n";
close LOGFILE;
if (-e $fn){
  open LOGFILE, ">>/home/mno/strategiske-tjenester/rubrikk/ap-spesifikt/okonomi/import.log";
  print LOGFILE "$TID2: FILEN EKSISTERER\n";
  close LOGFILE;
  handlexsltfast($fn);
  system("perl -nle 'print unless 1 .. 1' $fn >> $f");
  unlink $fn;
  open (HANDLE, "$f");
  @lines=<HANDLE>;$LINE0=$lines[0];$LINE1=$lines[1];
  @winners=split(/,/,$LINE0);@losers=split(/,/,$LINE1);
  $winnersUrl="http://msxml.tenfore.com/index.php?username=AfAf03906&password=QUFGP7&instrument=174.1.".$winners[0].",174.1.".$winners[1].",174.1.".$winners[2].",174.1.".$winners[3].",174.1.".$winners[4]."&fields=D2,D20,S12";
  $losersUrl="http://msxml.tenfore.com/index.php?username=AfAf03906&password=QUFGP7&instrument=174.1.".$losers[0].",174.1.".$losers[1].",174.1.".$losers[2].",174.1.".$losers[3].",174.1.".$losers[4]."&fields=D2,D20,S12";
  close (HANDLE);
  unlink $f;
  @URLS=($winnersUrl,$losersUrl);
  @FILES=('morningstar-stock-winners.xml','morningstar-stock-losers.xml');
  my $NR=0;
  my $SEARCHWORD = '<fld';
  my $SEARCHWORD2 = '/>';
  my $ERRORFILE = 'morningstar-feilfil.xml';
  my $TID = localtime(time);
  @SCPHOSTS = ('aipub.aftenposten.no','aiweb1.aftenposten.no','aiweb2.aftenposten.no','aiweb9.aftenposten.no','aiweb10.aftenposten.no');
  my $SCPUSER = 'syncdat';
  my $SCPDIR  = '/export/home/syncdat/six-i-q/';
  my $HOSTNR=0;
  my $WASHAWAY='xmlns=\"http:\/\/msxml.tenfore.com\" xmlns:xsi=\"http:\/\/www.w3.org\/2001\/XMLSchema-instance\" xsi:schemaLocation=\"http:\/\/msxml.tenfore.com TenforeXMLSchema.xsd\"';
  foreach (@URLS){
    my $SIQFILE = $FILES[$NR];
    my(@content) = get($URLS[$NR]);
    my $error = 1;
    my $parsable = 1;
    foreach my $line (@content) {
      if($line =~ /$SEARCHWORD/) {
        $error = 0;
      }
    }
    if($error == 1) {
      open LOGFILE, ">>/home/mno/strategiske-tjenester/rubrikk/ap-spesifikt/okonomi/import.log";
      print LOGFILE "$TID: FEIL - $URLS[$NR] ga feil resultat\n";
      close LOGFILE;
    }
    if($error == 0) {
      foreach my $line2 (@content) {
        if($line2 =~ /$SEARCHWORD2/) {
          $parsable = 0;
        }
      }
      if($parsable == 1) {
        open FILE, '>/home/mno/strategiske-tjenester/rubrikk/ap-spesifikt/okonomi/' . $SIQFILE;
        foreach my $line (@content) {
          print FILE $line;
        }
        close FILE;
        system("perl -pi -e 's/$WASHAWAY/ /g' /home/mno/strategiske-tjenester/rubrikk/ap-spesifikt/okonomi/$SIQFILE");
        $HOSTNR=0;
        foreach (@SCPHOSTS){
          $scp = Net::SCP->new( { "host"=>$SCPHOSTS[$HOSTNR], "user"=>$SCPUSER, timeout => 15 } );
          $scp->cwd($SCPDIR);
          $scp->put("/home/mno/strategiske-tjenester/rubrikk/ap-spesifikt/okonomi/".$SIQFILE) or die $scp->{errstr};
          $HOSTNR++;
        }$scp->quit;
      }
    }
    $NR++;
  }
}