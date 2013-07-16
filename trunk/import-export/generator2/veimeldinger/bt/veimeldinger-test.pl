#!/usr/bin/perl
use LWP::Simple;
use Net::SFTP::Foreign;
use Encode; # use this to encode into utf-8
################################################
my $URL = 'http://www.vegvesen.no/trafikk/xml/search.xml?searchFocus.counties=12&searchFocus.counties=14&searchFocus.roadTypes=Alle&searchFocus.roadNumber=&searchFocus.sortOrder=3';
my $SEARCHWORD = 'searchresult';
my $SFTPFILE = 'bt-veimeldinger.xml';
################################################
my $SFTPUSER = 'mno';
my $SFTPHOST = '80.91.41.41';
my $SFTPDIR  = '/data/external/veimeldinger';
my $ERRORFILE = 'veimeldinger-feilfil.xml';
my $IMPORTDIR = '/home/mno/veimeldinger/bt/data-test/';
################################################
my(@content) = get($URL);
my $TID = localtime(time);
my $error = 1;
foreach my $line (@content) {
    if($line =~ /$SEARCHWORD/) {
        $error = 0;
    }
}
if($error == 1) {
    open LOGFILE, ">>/home/mno/veimeldinger/bt/import-test.log";
    print LOGFILE "$TID: FEIL - $URL ga feil resultat\n";
    close LOGFILE;
}
if($error == 0) {
   open FILE, '>/home/mno/veimeldinger/bt/data-test/' . $SFTPFILE;
   foreach my $line (@content) {
       $line = decode('utf-8', $line); # this encodes to utf-8 
	print FILE $line;
    }

    $sftp = Net::SFTP::Foreign->new("$SFTPUSER\@$SFTPHOST", timeout => 15);
    if (!$sftp->error) {
        print "Connection OK.\n";
        if (!$sftp->put("$IMPORTDIR/$SFTPFILE","$SFTPDIR/$SFTPFILE")) {
            print "Upload $SFTPFILE to site $SFTPHOST failed. Will try again.\n";
            print "ERROR: " . $sftp->error . "\n";
        }
        undef $sftp;
    }

}
